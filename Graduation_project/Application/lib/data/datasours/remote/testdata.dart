// import 'package:graduation_project/core/class/curd.dart';

// class testdata {
//   crud cr;
//   testdata(this.cr);
//   getdata() async {
//     var respons= await cr.postdata(, {})

//   }
// }
class Job {
  int jobId;
  String jobName;

  Job({required this.jobId, required this.jobName});
}

// class user {
//   int user_id;
//   String user_name;
//   String phone_number;
//   String gmail;
//   String password;
//   String cpassword;
//   String city;
//   user(this.user_id, this.user_name, this.gmail, this.phone_number,
//       this.password, this.cpassword, this.city);
//   Map<String, dynamic> toJson() => {
//         'user_id': user_id.toString(),
//         'user_name': user_name,
//         'gmail': gmail,
//         'phone_number': phone_number,
//         'password': password,
//         'cpassword': cpassword,
//         'city': city
//       };
// }

class users {
  String user_name;
  String phone_number;
  String gmail;
  String password;
  String cpassword;
  String city;
  users(this.user_name, this.gmail, this.phone_number, this.password,
      this.cpassword, this.city);
  Map<String, dynamic> toJson() => {
        'user_name': user_name,
        'gmail': gmail,
        'phone_number': phone_number,
        'password': password,
        'cpassword': cpassword,
        'city': city
      };
}

class craft {
  String user_name;
  String phone_number;
  String gmail;
  String password;
  String cpassword;
  String city;
  String jobName;
  String price;
  String ema;
  String ti;
  int jobId;
  List<Job> jobs = [
    Job(jobId: 1, jobName: 'Carpenter'),
    Job(jobId: 2, jobName: 'Cleaning'),
    Job(jobId: 3, jobName: 'Driver'),
    Job(jobId: 4, jobName: 'Elecrician'),
    Job(jobId: 5, jobName: 'Gardener'),
    Job(jobId: 6, jobName: 'Painter'),
    Job(jobId: 7, jobName: 'Tailor'),
    Job(jobId: 8, jobName: 'Plumber'),
    Job(jobId: 9, jobName: 'Smith'),
    Job(jobId: 10, jobName: 'Tiler'),
  ];

  Job? selectedJob;
  craft(
      this.user_name,
      this.gmail,
      this.phone_number,
      this.password,
      this.cpassword,
      this.city,
      this.jobName,
      this.price,
      this.ema,
      this.ti,
      this.jobId);
  Map<String, dynamic> toJson() => {
        'user_name': user_name,
        'craftmen_gmail': gmail,
        'craftmen_phone': phone_number,
        'password': password,
        'cpassword': cpassword,
        'craftmen_city': city,
        'job': jobName,
        'price': price,
        'emergency': ema,
        'working_day': ti,
        'jop_id': jobId.toString()
      };
}
