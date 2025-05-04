using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace HospitalManagementSystem.Controllers
{
    public class HomeController : Controller
    {

        //SQL Connection

        public ActionResult Index()
        {
            // Select data from department table
            string query = "select * from Department order by Sr asc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        // Contact Us ....................
        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact us page.";
            return View();
        }
        [HttpPost]
        public ActionResult SaveContact(String name, String phone, String email, String subject, String message)
        {
            string query = $"insert into Contactus values ('{name}', '{phone}', '{email}', '{subject}', '{message}', '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}')";

            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result > 0)
            {
                return Content("<script>alert('Message Added Succesfully !'); location.href = '/home/contact'</script>");
            }
            else
            {
                return Content("<script>alert('Message Not Added !'); location.href = '/home/contact'</script>");
            }
        }

        // Services.....................
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
        

        // Testimonial.......................
        public ActionResult Testimonial()
        {
            // Select data from feedback table
            string query = "select * from Feedback left join Pt_Registration on Feedback.Pt_Id = Pt_Registration.Pt_Id order by Sr desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }

        // Registration.......................
        public ActionResult Registration()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SaveRegistrationData(String name, String fname, String dob, String gender, String email, String phone, String adhar, String add, String maritalstatus,  HttpPostedFileBase pic, String passwd)
        {
            String query = $"insert into Pt_Registration values ('{name}', '{fname}', '{dob}', '{phone}',  '{email}', '{gender}', '{adhar}', '{add}', '{maritalstatus}', '{passwd}', '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}', '{pic.FileName}')";

            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result > 0)
            {
                pic.SaveAs(Server.MapPath("/Content/img/patient/" + pic.FileName));
                return Content("<script>alert('Registered Succesfully! You can Login Now.'); location.href = '/home/registration'</script>");
            }
            else
            {
                return Content("<script>alert('Registration Failed! Try Agail.'); location.href = '/home/registration'</script>");
            }
        }

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

        
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SignIn(String utype, String userid, String pwd)
        {
            if (utype == "Admin") 
            {
                if (userid.Equals("admin@gmail.com") && pwd.Equals("a@123"))
                {
                    Session["admin"] = userid;
                    return RedirectToAction("dashboard", "admin");
                }
                else
                {
                    return Content("<script>alert('Invalid Id and Password!'); location.href = '/home/login'</script>");
                }
            }
            else if (utype == "Patient") 
            {
                string query = $"select * from Pt_Registration where Email_Id = '{userid}' and Password = '{pwd}'";
                SqlDataAdapter adapter = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    Session["Pt_Id"] = dt.Rows[0]["Pt_Id"];
                    Session["Name"] = dt.Rows[0]["Name"];
                    Session["Email"] = dt.Rows[0]["Email_Id"];

                    return RedirectToAction("patientprofile", "patient");
                }
                else
                {
                    return Content("<script>alert('Invalid Id and Password!'); location.href = '/home/login'</script>");
                }
            }
            else if (utype == "Doctor") 
            {
                string query = $"select * from Dr_Registration where Email = '{userid}' and Password = '{pwd}'";
                SqlDataAdapter adapter = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    Session["Dr_Id"] = dt.Rows[0]["Dr_Id"];
                    Session["Name"] = dt.Rows[0]["Name"];
                    Session["Email"] = dt.Rows[0]["Email"];

                    return RedirectToAction("drprofile", "doctor");
                }
                else
                {
                    return Content("<script>alert('Invalid Id and Password!'); location.href = '/home/login'</script>");
                }
            }
            else if (utype == "Laboratorian") 
            {
                if (userid.Equals("Laboratorian@gmail.com") && pwd.Equals("lab@123"))
                {
                    Session["Laboratorian"] = userid;
                    return RedirectToAction("Appointment", "Laboratorian");
                }
                else
                {
                    return Content("<script>alert('Invalid Id and Password!'); location.href = '/home/login'</script>");
                }
            }
            else 
            {
                return Content("<script>alert('Invalid User1'); location.href = '/home/login'</script>");
            }
        }





    }
}