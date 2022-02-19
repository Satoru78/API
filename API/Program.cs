using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Buffers;
using System.Text.Json;
using System.Net;
using System.Text.Unicode;
using System.Text.Encodings.Web;
using API.Model;
using System.IO;

namespace API
{
    class Program
    {
        static void Main()
        {
            HttpListener server = new HttpListener();
            server.Prefixes.Add("http://localhost:21034/");

            JsonSerializerOptions options = new JsonSerializerOptions() { Encoder = JavaScriptEncoder.Create(UnicodeRanges.All) };
            server.Start();

            while (true)
            {
                HttpListenerContext context = server.GetContext();
                if(context.Request.HttpMethod == "GET")
                {
                    try
                    {
                        if (context.Request.RawUrl == "/api/bike")
                        {
                            var bikeList = Data.bd.Bike.ToList();
                            string response = JsonSerializer.Serialize(Data.bd.Bike.ToList().ConvertAll(b => new ResponseBike(b)), options);
                            byte[] data = Encoding.UTF8.GetBytes(response);
                            context.Response.ContentType = "application/json;charset=utf-8";
                            using (Stream stream = context.Response.OutputStream)
                            {
                                context.Response.StatusCode = 200;
                                stream.Write(data, 0, data.Length);
                            }
                        }
                        else throw new Exception();
                    }
                    catch
                    {
                        context.Response.StatusCode = 400;
                        context.Response.Close();
                    }
                }
                else if (context.Request.HttpMethod == "POST")
                {
                    try
                    {
                        if(context.Request.RawUrl == "/api/bike")
                        {
                            if(context.Request.ContentType == "application/json")
                            {
                                string request = "";
                                byte[] data = new byte[context.Request.ContentLength64];
                                using (Stream stream = context.Request.InputStream)
                                {
                                    stream.Read(data, 0, data.Length);
                                }
                                request = System.Text.UTF8Encoding.UTF8.GetString(data);
                                var bikeList = JsonSerializer.Deserialize<List<ResponseBike>>(request);
                                foreach (var bike in bikeList)
                                {
                                    Bike bikes = new Bike();
                                    bikes.ID = bike.ID;
                                    bikes.Title = bike.Title;
                                    bikes.Owner = bike.Owner;
                                    bikes.IDStatus = bike.IDStatus;
                                    bikes.IDType = bike.IDType;
                                    bikes.Date = bike.Date;
                                    Data.bd.Bike.Add(bikes);
                                }
                                Data.bd.SaveChanges();
                                context.Response.StatusCode = 200;
                                context.Response.Close();
                            }
                            else
                            {
                                throw new Exception();
                            }
                        }
                        else
                        {
                            throw new Exception();
                        }
                    }
                    catch
                    {
                        context.Response.StatusCode = 400;
                        context.Response.Close();
                    }
                }
                else
                {
                    try
                    {
                        if(context.Request.HttpMethod == "DELETE")
                        {
                            if(context.Request.QueryString.Count == 1)
                            {
                                if(context.Request.QueryString.Keys[0] == "id")
                                {
                                    int id = Convert.ToInt32(context.Request.QueryString.Get(0));
                                    var currentBike = Data.bd.Bike.FirstOrDefault(b => b.ID == id);
                                    if (currentBike != null)
                                    {
                                        Data.bd.Bike.Remove(currentBike);
                                        Data.bd.SaveChanges();
                                        context.Response.StatusCode = (int)HttpStatusCode.OK;
                                        context.Response.Close();
                                    }
                                    else
                                    {
                                        throw new Exception();
                                    }
                                }
                                else
                                {
                                    throw new Exception();
                                }
                            }
                            else
                            {
                                throw new Exception();
                            }
                        }
                        else
                        {
                            throw new Exception();
                        }
                    }
                    catch
                    {
                        context.Response.StatusCode = 400;
                        context.Response.Close();
                    }
                }
            }
        }
    }
}
