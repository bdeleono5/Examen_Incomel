using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Incomel.Model
{
    public class Empleado
    {
        public int id { get; set; }
        public string DPI { get; set; }
        public string nombre { get; set; }
        public string correo { get; set; }
        public DateTime fecha_nacimiento { get; set; }
        public int cant_hijos { get; set; }
        public decimal salario_base { get; set; }
        public decimal bono_decreto { get; set; }
        public decimal IGSS { get; set; }
        public decimal IRTRA { get; set; }
        public decimal bono_paternidad { get; set; }
        public decimal salario_total { get; set; }
        public decimal salario_liquido { get; set; }
        public int estado { get; set; }
        public Enum.Estado EstadoE
        {
            get { return (Enum.Estado)Convert.ToInt32(this.estado); }
            set { this.estado = Convert.ToInt32(value); }
        }

    }
}
