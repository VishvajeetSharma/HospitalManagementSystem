using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.WebPages;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.Services.Description;
using System.Xml.Linq;
using System.Security.Cryptography;
using System.Net.Configuration;
using System.Net.Mail;
using System.Net;

namespace HospitalManagementSystem.Controllers
{
    public class AdminController : Controller
    {
        //SQL Connection String.........................

        public ActionResult Dashboard()
        {
            // select to 5 rows from dr appointments
            String query = $"select top 5 * from Dr_Appointment left join Pt_Registration on Dr_Appointment.Pt_Id = Pt_Registration.Pt_Id left join Dr_Registration on Dr_Appointment.Department = Dr_Registration.Assigned_Department where cast(App_Date as datetime) + cast(App_Time as datetime) > getdate() order by cast(App_Date as datetime) + cast(App_Time as datetime) asc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            // Select data from Doctor Registration table
            string query1 = "select top 5 * from Dr_Registration left join Department on Dr_Registration.Assigned_Department = Department.Sr order by Dr_Id desc";
            SqlDataAdapter sda1 = new SqlDataAdapter(query1, con);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);

            // Select data from Patient Registration table
            string query3 = "select top 5 * from Pt_Registration order by Pt_Id desc";
            SqlDataAdapter sda3 = new SqlDataAdapter(query3, con);
            DataTable dt3 = new DataTable();
            sda3.Fill(dt3);

            // select top 5 rows from lab test apointments
            String query4 = $"select top 5 * from LAB_Appointment left join Pt_Registration on LAB_Appointment.Pt_Id = Pt_Registration.Pt_Id left join Services on LAB_Appointment.TName = Services.Sr where cast(T_Date as datetime) + cast(T_Time as datetime) > getdate() order by cast(T_Date as datetime) + cast(T_Time as datetime) asc";
            SqlDataAdapter sda4 = new SqlDataAdapter(query4, con);
            DataTable dt4 = new DataTable();
            sda4.Fill(dt4);

            ViewBag.table = dt;
            ViewBag.table1 = dt1;
            ViewBag.table3 = dt3;

            ViewBag.table4 = dt4;

            return View();
        }

        // Admin Doctors Section...............
        public ActionResult Doctors()
        {
            // Select data from Doctor Registration table
            string query = "select * from Dr_Registration left join Department on Dr_Registration.Assigned_Department = Department.Sr order by Dr_Id desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        public ActionResult AddDoctor()
        {
            // Select department name from department table
            string query = "select * from Department order by Sr asc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        [HttpPost]
        public ActionResult AddDr(String name, String phone, String email, String adhar, String gender, String dob, String add, HttpPostedFileBase pic , String qualification, String exp, int? adipartment, String passwd)
        {
            // Insert data into Dr Registration Table.................
            string query = $"insert into Dr_Registration values ('{name}', '{phone}','{email}', '{adhar}', '{gender}', '{dob}', '{add}', '{pic.FileName}', '{qualification}', '{exp}', {adipartment}, '{passwd}', '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}')";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result > 0)
            {
                pic.SaveAs(Server.MapPath("/Content/img/doctor/" + pic.FileName));
                return RedirectToAction("Doctors");
            }
            else
            {
                return Content("<script>alert('Doctor Not Added! Try Again.'); location.href = '/admin/adddoctor'</script>");
            }
        }
        public ActionResult DeleteDoctor(String Sr)
        {
            if (!Sr.IsEmpty())
            {
                string query = $"delete from Dr_Registration where Dr_Id = '{Sr}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Doctor Deleted.'); location.href = '/admin/doctors'</script>");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/admin/doctorss'</script>");
            }
        }

        // Admin Patient Section...............
        public ActionResult Patients()
        {
            // Select data from Patient Registration table
            string query = "select * from Pt_Registration order by Pt_Id desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        public ActionResult DeletePt(String Pt_Id)
        {
            if (!Pt_Id.IsEmpty())
            {
                string query = $"delete from Pt_Registration where Pt_Id = '{Pt_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Patient Deleted.'); location.href = '/admin/patients'</script>");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/admin/patients'</script>");
            }
        }


        public ActionResult Appointments()
        {
            string query = $"select * from Dr_Appointment left join Pt_Registration on Dr_Appointment.Pt_Id = Pt_Registration.Pt_Id left join Dr_Registration on Dr_Appointment.Dr_Id = Dr_Registration.Dr_Id left join Department on Dr_Appointment.Department = Department.Sr order by Dr_Appointment.Ap_Id desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        public ActionResult AssignDr(String Ap_Id)
        {
            string query = $"select * from Dr_Appointment left join Dr_Registration on Dr_Appointment.Department = Dr_Registration.Assigned_Department where Ap_Id = '{Ap_Id}'";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        [HttpPost]
        public ActionResult SaveDr(int? assigndr, String Ap_Id) 
        {

            string query = $"update Dr_Appointment set Dr_Id = '{assigndr}' where Ap_Id = '{Ap_Id}'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int r = cmd.ExecuteNonQuery();
            con.Close();

            return RedirectToAction("Appointments");
        }
        public ActionResult UpdateStatus(int? Ap_Id, String Status)
        {
            if (Ap_Id.HasValue && !Status.IsEmpty())
            {
                string query = $"update Dr_Appointment set Status = 'Approved' where Ap_Id = '{Ap_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Status Updated.'); location.href = '/admin/appointments'</script>");
            }
            else
            {
                return Content("<script>alert('Try again !'); location.href = '/admin/appointments'</script>");
            }
        }
        public ActionResult DeleteDrApp(String Ap_Id)
        {
            if (!Ap_Id.IsEmpty())
            {
                string query = $"delete from Dr_Appointment where Ap_Id = '{Ap_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return RedirectToAction ("Appointments");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/admin/appointments'</script>");
            }
        }

        public ActionResult LabAppointment()
        {
            string query = $"select * from LAB_Appointment left join Pt_Registration on LAB_Appointment.Pt_Id = Pt_Registration.Pt_Id left join Services on LAB_Appointment.TName = Services.Sr order by LAB_Appointment.T_Id desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        public ActionResult UpdateLabStatus(int? T_Id, String Status)
        {
            if (T_Id.HasValue && !Status.IsEmpty())
            {
                string query = $"update LAB_Appointment set Status = 'Approved' where T_Id = '{T_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Status Updated.'); location.href = '/admin/labappointment'</script>");
            }
            else
            {
                return Content("<script>alert('Try again !'); location.href = '/admin/labappointment'</script>");
            }
        }
        public ActionResult DeleteLabApp(String T_Id)
        {
            if (!T_Id.IsEmpty())
            {
                string query = $"delete from LAB_Appointment where T_Id = '{T_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return RedirectToAction("labAppointment");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/admin/labappointment'</script>");
            }
        }

        public ActionResult DoctorsSchedule()
        {
            return View();
        }


        // Admin Department Section.................
        public ActionResult Department()
        {
            // Select data from department table
            string query = "select * from Department order by Sr desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        public ActionResult AddDep()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SaveDep(String depname)
        {
            string query = $"insert into Department values ('{depname}', '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}')";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result > 0)
            {
                return RedirectToAction("Department");
            }
            else
            {
                return Content("<script>alert('Message Not Added !'); location.href = '/adddep'</script>");
            }
        }
        public ActionResult DeleteDep(string Sr)
        {
            if (!Sr.IsEmpty())
            {
                string query = $"delete from Department where Sr = '{Sr}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Department Deleted.'); location.href = '/admin/department'</script>");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/admin/department'</script>");
            }
        }


        // Admin Services Section.........
        public ActionResult Services()
        {
            // Select data from services table
            string query = "select * from Services left join Department on Services.DepSr = Department.Sr order by Services.Sr desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        public ActionResult AddServices()
        {
            // Select data from department table
            string query = "select * from Department order by Sr desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        [HttpPost]
        public ActionResult AddService(String servicename, String depsr)
        {
            string query = $"insert into Services values ('{servicename}', '{depsr}', '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}')";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result > 0)
            {
                return RedirectToAction("Services");
            }
            else
            {
                return Content("<script>alert('Message Not Added !'); location.href = '/addservices'</script>");
            }
        }
        public ActionResult DeleteServices(string Sr)
        {
            if (!Sr.IsEmpty())
            {
                string query = $"delete from services where Sr = '{Sr}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Service Deleted.'); location.href = '/admin/services'</script>");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/admin/services'</script>");
            }
        }






        public ActionResult ManageEnquary() {
            // Select data from contactus table
            string query = "select * from contactus order by Sr desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();    
        }
        public ActionResult WriteEmail(String EmailId)
        {
            // Store the EmailId in session
            Session["EmailId"] = EmailId;
            return View();
        }
        [HttpPost]
        public ActionResult SendEmail(String emailreply)
        {
            string EmailId = Session["EmailId"] as string;
            var fromAddress = new MailAddress("your_emailId", "Your_name");
            var toAddress = new MailAddress(EmailId);

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential("your_emailId", "16_char_app_code")
            };

            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = "Your Mediplus Enquiry Reply",
                Body = emailreply
            })
            {
                smtp.Send(message);
            }

            return RedirectToAction("ManageEnquary");
        }
        public ActionResult DeleteEnq(string Sr)
        {
            if (!Sr.IsEmpty())
            {
                string query = $"delete from ContactUs where Sr = '{Sr}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Feedback Deleted.'); location.href = '/admin/manageenquary'</script>");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/admin/manageenquary'</script>");
            }
        }





        // Patient's Feedback.......................
        public ActionResult Feedback() {
            // Select data from feedback table
            string query = "select * from Feedback left join Pt_Registration on Feedback.Pt_Id = Pt_Registration.Pt_Id order by Sr desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View(); 
        }
        public ActionResult DeleteFeedback(String Sr) 
        {
            if (!Sr.IsEmpty())
            {
                string query = $"delete from feedback where Sr = '{Sr}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Feedback Deleted.'); location.href = '/admin/feedback'</script>");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/admin/feedback'</script>");
            }
        }



        public ActionResult logout()
        {
            Session.Remove("admin");
            return RedirectToAction("Index", "Home");
        }

    }
}