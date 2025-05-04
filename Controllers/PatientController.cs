using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;

namespace HospitalManagementSystem.Controllers
{
    public class PatientController : Controller
    {
        //SQL Connection String.......................

        public ActionResult Dashboard()
        {
            return View();
        }


        public ActionResult PatientProfile() 
        {
            int Pt_Id = Convert.ToInt32(Session["Pt_Id"]);
            // Selectying All data from patient registration table...............
            String query = $"select * from Pt_Registration where Pt_Id = {Pt_Id}";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            // select last one data from dr appointment table..................
            String query1 = $"select top 1 * from Dr_Appointment left join Pt_Registration on Dr_Appointment.Pt_Id = Pt_Registration.Pt_Id left join Dr_Registration on Dr_Appointment.Department = Dr_Registration.Assigned_Department where cast(App_Date as datetime) + cast(App_Time as datetime) < getdate() and Dr_Appointment.Pt_Id = {Pt_Id} order by cast(App_Date as datetime) + cast(App_Time as datetime) desc";
            SqlDataAdapter sda1 = new SqlDataAdapter(query1, con);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);

            String query2 = $"select top 1 * from Dr_Appointment left join Pt_Registration on Dr_Appointment.Pt_Id = Pt_Registration.Pt_Id left join Dr_Registration on Dr_Appointment.Department = Dr_Registration.Assigned_Department where cast(App_Date as datetime) + cast(App_Time as datetime) > getdate() and Dr_Appointment.Pt_Id = {Pt_Id} order by cast(App_Date as datetime) + cast(App_Time as datetime) asc";
            SqlDataAdapter sda2 = new SqlDataAdapter(query2, con);
            DataTable dt2 = new DataTable();
            sda2.Fill(dt2);

            // select last one data from lab appointment table..................
            String query3 = $"select top 1 * from LAB_Appointment where cast(T_Date as datetime) + cast(T_Time as datetime) < getdate() and LAB_Appointment.Pt_Id = {Pt_Id} order by cast(T_Date as datetime) + cast(T_Time as datetime) desc";
            SqlDataAdapter sda3 = new SqlDataAdapter(query3, con);
            DataTable dt3 = new DataTable();
            sda3.Fill(dt3);

            String query4 = $"select top 1 * from LAB_Appointment where cast(T_Date as datetime) + cast(T_Time as datetime) > getdate() and LAB_Appointment.Pt_Id = {Pt_Id} order by cast(T_Date as datetime) + cast(T_Time as datetime) asc";
            SqlDataAdapter sda4 = new SqlDataAdapter(query4, con);
            DataTable dt4 = new DataTable();
            sda4.Fill(dt4);

            ViewBag.table = dt;
            ViewBag.table1 = dt1;
            ViewBag.table2 = dt2;
            ViewBag.table3 = dt3;
            ViewBag.table4 = dt4;
            return View();
        }


        public ActionResult DAppointment() 
        {
            int Pt_Id = Convert.ToInt32(Session["Pt_Id"]);
            String query = $"select * from Dr_Appointment left join Dr_Registration on Dr_Appointment.Department = Dr_Registration.Assigned_Department left join Department on Dr_Appointment.Department = Department.Sr where Pt_Id = {Pt_Id}";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }

        public ActionResult AddDAppointment() 
        {
            int Pt_Id = Convert.ToInt32(Session["Pt_Id"]);
            String query = $"select * from Pt_Registration where Pt_Id = {Pt_Id}";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            // Select department name from department table
            string query1 = "select * from Department order by Sr asc";
            SqlDataAdapter sda1 = new SqlDataAdapter(query1, con);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);

            ViewBag.table = dt;
            ViewBag.table1 = dt1;
            return View();
        }
        [HttpPost]
        public ActionResult addappwdr(int? department, String date, String time, String reason)
        {
            int Pt_Id = Convert.ToInt32(Session["Pt_Id"]);
            string query = $"insert into Dr_Appointment (Pt_Id, Department, App_Date, App_Time, Reason, Submitted_At) values ({Pt_Id}, {department}, '{date}','{time}', '{reason}', '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}')";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result > 0)
            {
                return RedirectToAction("DAppointment");
            }
            else
            {
                return Content("<script>alert('Appointment Not Added! Try Again.'); location.href = '/daapointment'</script>");
            }
        }



        public ActionResult LabAppointment() {
            int Pt_Id = Convert.ToInt32(Session["Pt_Id"]);
            String query = $"select * from LAB_Appointment left join Services on LAB_Appointment.TName = Services.Sr where LAB_Appointment.Pt_Id = {Pt_Id}";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ViewBag.table = dt;

            return View();
        }

        public ActionResult AddLabAppointment() {
            int Pt_Id = Convert.ToInt32(Session["Pt_Id"]);
            String query = $"select * from Pt_Registration where Pt_Id = {Pt_Id}";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            String query1 = $"select * from Services where DepSr = 3";
            SqlDataAdapter sda1 = new SqlDataAdapter(query1, con);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);

            ViewBag.table = dt;
            ViewBag.table1 = dt1;

            return View();
        }
        [HttpPost]
        public ActionResult AddLabTest(String tname, string date, string time)
        {
            int Pt_Id = Convert.ToInt32(Session["Pt_Id"]);
            string query = $"insert into Lab_Appointment (Pt_Id, TName, T_Date, T_Time, Submitted_At) values ({Pt_Id}, '{tname}', '{date}','{time}', '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}')";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result > 0)
            {
                return RedirectToAction("LabAppointment");
            }
            else
            {
                return Content("<script>alert('Appointment Not Added! Try Again.'); location.href = '/addlabapointment'</script>");
            }
        }


        // Feedback.............................
        public ActionResult Feedback() {
            return View();
        }
        [HttpPost]
        public ActionResult SaveFeedback(String msg)
        {
            int Pt_Id = Convert.ToInt32(Session["Pt_Id"]);
            string query = $"insert into Feedback values ({Pt_Id}, '{msg}', '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}')";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result > 0)
            {
                return RedirectToAction("Feedback");
            }
            else
            {
                return Content("<script>alert('Feedback Not Added! Try Again.'); location.href = '/feedback'</script>");
            }
        }


        public ActionResult logout()
        {
            Session.Remove("email");
            return Content("<script>alert('Logged out'); location.href = '/home/index'</script>");
        }
    }
}