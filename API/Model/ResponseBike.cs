using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace API.Model
{
    public class ResponseBike
    {
        public ResponseBike(Bike bike)
        {
            this.ID = bike.ID;
            this.Title = bike.Title;
            this.Owner = bike.Owner;
            this.IDStatus = bike.IDStatus;
            this.IDType = bike.IDType;
            this.Date = bike.Date;
        }
        public ResponseBike() { }
        public int ID { get; set; }
        public string Title { get; set; }
        public string Owner { get; set; }
        public int IDStatus { get; set; }
        public int IDType { get; set; }
        public System.DateTime Date { get; set; }
    }
}
