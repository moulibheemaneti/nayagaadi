import 'package:naya/models/Model.dart';
class Repoistry{
  List<Map>getAll() => india;
  getLocaleByState(String state)=> india
  .map((map) => StateModel.fromJson(map))
  .where((item) => item.state == state)
  .map((item) => item.districts)
  .expand((element) => element).toList();
  List<String>getStates() => india
  .map((map) => StateModel.fromJson(map))
  .map((item) => item.state).toList();
List india = [
  // Andaman and Nicobar (AN) - 3
  {
    "state":"Andaman and Nicobar",
    "districts":[
      "Nicobar",
      "North and Middle Andaman",
      "South Andaman"
    ]
  },

  // Andhra Pradesh (AP) - 13
  {
    "state":"Andhra Pradesh",
    "districts":[
      "Anantapur",
      "Chittoor",
      "East Godavari",
      "Guntur",
      "YSR Kadapa",
      "Krishna",
      "Kurnool",
      "Nellore",
      "Prakasam",
      "Srikakulam",
      "Vishakapatnam",
      "Vizianagaram",
      "West Godavari"
    ]
  },

  // Arunachal Pradesh (AR) - 25
  {
    "state":"Arunachal Pradesh",
    "districts":[
      "Anjaw",
      "Changlang",
      "Dibang Valley",
      "East Kameng",
      "East Siang",
      "Kamle",
      "Kra Daadi",
      "Kurung Kumey",
      "Lepa-Rada",
      "Lohit",
      "Longding",
      "Lower Dibang Valley",
      "Lower Siang",
      "Lower Subansiri",
      "Namsai",
      "Pakke-Kessang",
      "Papum Pare",
      "Shi-Yomi",
      "Siang",
      "Tawang",
      "Tirap",
      "Upper Siang",
      "Upper Subansiri",
      "West Kameng",
      "West Siang"
    ]
  },

  // // Assam (AS) - 33
  {
    "state":"Assam",
    "districts":[
      "Baksa",
      "Barpeta",
      "Biswanath",
      "Bongaigaon",
      "Cachar",
      "Charaideo",
      "Chirang",
      "Darrang",
      "Dhemaji",
      "Dhubri",
      "Dibrugarh",
      "Dima Hasao",
      "Goalpara",
      "Golaghat",
      "Hailakandi",
      "Hojai",
      "Jorhat",
      "Kamrup",
      "Kamrup Metropolitan",
      "Karbi Anglong",
      "Karimganj",
      "Kokrajhar",
      "Lakhimpur",
      "Majuli",
      "Morigaon",
      "Nagaon",
      "Nalbari",
      "Sivasagar",
      "Sonitpur",
      "South Salmara-Mankachar",
      "Tinsukia",
      "Udalguri",
      "West Karbi Anglong"
    ]
  },

  // Bihar (BR) - 38
  {
    "state":"Bihar",
    "districts":[
      "Araria",
      "Arwal",
      "Aurangabad",
      "Banka",
      "Begusarai",
      "Bhagalpur",
      "Bhojpur",
      "Buxar",
      "Darbhanga",
      "East Champaran",
      "Gaya",
      "Gopalganj",
      "Jamui",
      "Jehanabad",
      "Kaimur",
      "Katihar",
      "Khagaria",
      "Kishanganj",
      "Lakhisarai",
      "Madhepura",
      "Madhubani",
      "Munger",
      "Muzaffarpur",
      "Nalanda",
      "Nawada",
      "Patna",
      "Purnia",
      "Rohtas",
      "Saharsa",
      "Samastipur",
      "Saran",
      "Sheikhpura",
      "Sheohar",
      "Sitamarhi",
      "Siwan",
      "Supaul",
      "Vaishali",
      "West Champaran"
    ]
  },

  // Chandigarh (CH) - 1
  {
    "state":"Chandigarh",
    "districts":[
      "Chandigarh"
    ]
  },

  // Chhattisgarh (CT) - 28
  {
    "state":"Chhattisgarh",
    "districts":[
      "Balod",
      "Baloda Bazar",
      "Balrampur",
      "Bastar",
      "Bemetara",
      "Bijapur",
      "Bilaspur",
      "Dantewada",
      "Dhamtari",
      "Durg",
      "Gariaband",
      "Gaurela-Pendra-Marwahi",
      "Janjgir-Champa",
      "Jashpur",
      "Kabirdham",
      "Kanker",
      "Kondagaon",
      "Korba",
      "Koriya",
      "Mahasamund",
      "Mungeli",
      "Narayanpur",
      "Raigarh",
      "Raipur",
      "Rajnandgaon",
      "Sukma",
      "Surajpur",
      "Surguja"
    ]
  },

  // Dadra and Nagar Haveli (DN) - 1
  {
    "state":"Dadra and Nagar Haveli",
    "districts":[
      "Dadra and Nagar Haveli"
    ]
  },

  // Daman and Diu (DD) - 2
  {
    "state":"Daman and Diu",
    "districts":[
      "Daman",
      "Diu"
    ]
  },

  // National Capital Territory of Delhi (DL) - 11
  {
    "state":"Delhi",
    "districts":[
      "Central Delhi",
      "East Delhi",
      "New Delhi",
      "North Delhi",
      "North East Delhi",
      "North West Delhi",
      "Shahdara",
      "South Delhi",
      "South East Delhi",
      "South West Delhi",
      "West Delhi"
    ]
  },

  // GOA (GA) - 2
  {
    "state":"Goa",
    "districts":[
      "North Goa",
      "South Goa"
    ]
  },

  // Gujarat (GJ) - 33
  {
    "state":"Gujarat",
    "districts":[
      "Ahmedabad",
      "Amreli",
      "Anand",
      "Aravalli",
      "Banaskantha",
      "Bharuch",
      "Bhavnagar",
      "Botad",
      "Chhota Udepur",
      "Dahod",
      "Dang",
      "Devbhoomi Dwarka",
      "Gandhinagar",
      "Gir Somnath",
      "Jamnagar",
      "Junagadh",
      "Kheda",
      "Kutch",
      "Mahisagar",
      "Mehsana",
      "Morbi",
      "Narmada",
      "Navsari",
      "Panchmahal",
      "Patan",
      "Porbandar",
      "Rajkot",
      "Sabarkantha",
      "Surat",
      "Surendranagar",
      "Tapi",
      "Vadodara",
      "Valsad"
    ]
  },

  // Haryana (HR) - 22
  {
    "state":"Haryana",
    "districts":[
      "Ambala",
      "Bhiwani",
      "Charkhi Dadri",
      "Faridabad",
      "Fatehabad",
      "Gurgaon",
      "Hissar",
      "Jhajjar",
      "Jind",
      "Kaithal",
      "Karnal",
      "Kurukshetra",
      "Mahendragarh",
      "Nuh",
      "Palwal",
      "Panchkula",
      "Panipat",
      "Rewari",
      "Rohtak",
      "Sirsa",
      "Sonipat",
      "Yamuna Nagar"
    ]
  },

  // Himachal Pradesh (HP) - 12
  {
    "state":"Himachal Pradesh",
    "districts":[
      "Bilaspur",
      "Chamba",
      "Hamirpur",
      "Kangra",
      "Kinnaur",
      "Kullu",
      "Lahaul and Spiti",
      "Mandi",
      "Shimla",
      "Sirmaur",
      "Solan",
      "Una"
    ]
  },

  // Jammu and Kashmir (JK) - 20
  {
    "state":"Jammu and Kashmir",
    "districts":[
      "Anantnag",
      "Bandipora",
      "Baramulla",
      "Badgam",
      "Doda",
      "Ganderbal",
      "Jammu",
      "Kathua",
      "Kishtwar",
      "Kulgam",
      "Kupwara",
      "Poonch",
      "Pulwama",
      "Rajouri",
      "Ramban",
      "Reasi",
      "Samba",
      "Shopian",
      "Srinagar",
      "Udhampur"
    ]
  },

  // Jharkhand (JH) - 24
  {
    "state":"Jharkhand",
    "districts":[
      "Bokaro",
      "Chatra",
      "Deoghar",
      "Dhanbad",
      "Dumka",
      "East Singhbhum",
      "Garhwa",
      "Giridih",
      "Godda",
      "Gumla",
      "Hazaribag",
      "Jamtara",
      "Khunti",
      "Koderma",
      "Latehar",
      "Lohardaga",
      "Pakur",
      "Palamu",
      "Ramgarh",
      "Ranchi",
      "Sahibganj",
      "Seraikela Kharsawan",
      "Simdega",
      "West Singhbhum"
    ]
  },

  // Karnataka (KA) - 30
  {
    "state":"Karnataka",
    "districts":[
      "Bagalkot",
      "Ballari",
      "Belgaum",
      "Bangalore Rural",
      "Bangalore Urban",
      "Bidar",
      "Chamarajnagar",
      "Chikkaballapur",
      "Chikkamagaluru",
      "Chitradurga",
      "Dakshina Kannada",
      "Davanagere",
      "Dharwad",
      "Gadag",
      "Gulbarga",
      "Hassan",
      "Haveri",
      "Kodagu",
      "Kolar",
      "Koppal",
      "Mandya",
      "Mysuru",
      "Raichur",
      "Ramanagara",
      "Shimoga",
      "Tumakuru",
      "Udupi",
      "Uttara Kannada",
      "Vijayapura",
      "Yadgir"
    ]
  },

  // Kerala (KL) - 14
  {
    "state":"Kerala",
    "districts":[
      "Alappuzha",
      "Ernakulam",
      "Idukki",
      "Kannur",
      "Kasaragod",
      "Kollam",
      "Kottayam",
      "Kozhikode",
      "Malappuram",
      "Palakkad",
      "Pathanamthitta",
      "Thrissur",
      "Thiruvananthapuram",
      "Wayanad"
    ]
  },

  // Lakshadweep (LD) - 1
  {
    "state":"Lakshadweep",
    "districts":[
      "Lakshadweep"
    ]
  },

  // Madhya Pradesh (MP) -55
  {
    "state":"Madhya Pradesh",
    "districts":[
      "Agar Malwa",
      "Alirajpur",
      "Anuppur",
      "Ashok Nagar",
      "Balaghat",
      "Barwani",
      "Betul",
      "Bhind",
      "Bhopal",
      "Burhanpur",
      "Chachaura-Binaganj",
      "Chhatarpur",
      "Chhindwara",
      "Damoh",
      "Datia",
      "Dewas",
      "Dhar",
      "Dindori",
      "Guna",
      "Gwalior",
      "Harda",
      "Hoshangabad",
      "Indore",
      "Jabalpur",
      "Jhabua",
      "Katni",
      "Khandwa",
      "Khargone",
      "Maihar",
      "Mandla",
      "Mandsaur",
      "Morena",
      "Narsinghpur",
      "Nagda",
      "Neemuch",
      "Niwari",
      "Panna",
      "Raisen",
      "Rajgarh",
      "Ratlam",
      "Rewa",
      "Sagar",
      "Satna",
      "Sehore",
      "Seoni",
      "Shahdol",
      "Shajapur",
      "Sheopur",
      "Shivpuri",
      "Sidhi",
      "Singrauli",
      "Tikamgarh",
      "Ujjain",
      "Umaria",
      "Vidisha"
    ]
  },

  // Maharashtra (MH) - 36
  {
    "state":"Maharashtra",
    "districts":[
      "Ahmednagar",
      "Akola",
      "Amravati",
      "Aurangabad",
      "Beed",
      "Bhandara",
      "Buldhana",
      "Chandrapur",
      "Dhule",
      "Gadchiroli",
      "Gondia",
      "Hingoli",
      "Jalgaon",
      "Jalna",
      "Kolhapur",
      "Latur",
      "Mumbai City",
      "Mumbai Suburban",
      "Nanded",
      "Nandurbar",
      "Nagpur",
      "Nashik",
      "Osmanabad",
      "Palghar",
      "Parbhani",
      "Pune",
      "Raigad",
      "Ratnagiri",
      "Sangli",
      "Satara",
      "Sindhudurg",
      "Solapur",
      "Thane",
      "Wardha",
      "Washim",
      "Yavatmal"
    ]
  },

  // Manipur (MN) - 16
  {
    "state":"Manipur",
    "districts":[
      "Bishnupur",
      "Chandel",
      "Churachandpur",
      "Imphal East",
      "Imphal West",
      "Jiribam",
      "Kakching",
      "Kamjong",
      "Kangpokpi",
      "Noney",
      "Pherzawl",
      "Senapati",
      "Tamenglong",
      "Tengnoupal",
      "Thoubal",
      "Ukhrul"
    ]
  },

  // Meghalaya (ML) - 11
  {
    "state":"Meghalaya",
    "districts":[
      "East Garo Hills",
      "East Khasi Hills",
      "East Jaintia Hills",
      "North Garo Hills",
      "Ri Bhoi",
      "South Garo Hills",
      "South West Garo Hills",
      "South West Khasi Hills",
      "West Jaintia Hills",
      "West Garo Hills",
      "West Khasi Hills"
    ]
  },

  // Mizoram (MZ) - 11
  {
    "state":"Mizoram",
    "districts":[
      "Aizawl",
      "Champhai",
      "Hnahthial",
      "Khawzawl",
      "Kolasib",
      "Lawngtlai",
      "Lunglei",
      "Mamit",
      "Saiha",
      "Saitual",
      "Serchhip"
    ]
  },

  // Nagaland (NL) - 12
  {
    "state":"Nagaland",
    "districts":[
      "Dimapur",
      "Kiphire",
      "Kohima",
      "Longleng",
      "Mokokchung",
      "Mon",
      "Noklak",
      "Peren",
      "Phek",
      "Tuensang",
      "Wokha",
      "Zunheboto"
    ]
  },

  // Odisha (OR) - 30
  {
    "state":"Odisha",
    "districts":[
      "Angul",
      "Boudh",
      "Bhadrak",
      "Balangir",
      "Bargarh",
      "Balasore",
      "Cuttack",
      "Debagarh",
      "Dhenkanal",
      "Ganjam",
      "Gajapati",
      "Jharsuguda",
      "Jajpur",
      "Jagatsinghpur",
      "Khordha",
      "Kendujhar",
      "Kalahandi",
      "Kandhamal",
      "Koraput",
      "Kendrapara",
      "Malkangiri",
      "Mayurbhanj",
      "Nabarangpur",
      "Nuapada",
      "Nayagarh",
      "Puri",
      "Rayagada",
      "Sambalpur",
      "Subarnapur",
      "Sundargarh"
    ]
  },

  // Puducherry (PY) - 4
  {
    "state":"Puducherry",
    "districts":[
      "Karaikal",
      "Mahé",
      "Pondicherry",
      "Yanam"
    ]
  },

  // Punjab (PB) - 22
  {
    "state":"Punjab",
    "districts":[
      "Amritsar",
      "Barnala",
      "Bathinda",
      "Firozpur",
      "Faridkot",
      "Fatehgarh Sahib",
      "Fazilka",
      "Gurdaspur",
      "Hoshiarpur",
      "Jalandhar",
      "Kapurthala",
      "Ludhiana",
      "Mansa",
      "Moga",
      "Sri Muktsar Sahib",
      "Pathankot",
      "Patiala",
      "Rupnagar",
      "Sahibzada Ajit Singh Nagar",
      "Sangrur",
      "Shahid Bhagat Singh Nagar",
      "Tarn Taran"
    ]
  },

  // Rajasthan (RJ) - 33
  {
    "state":"Rajasthan",
    "districts":[
      "Ajmer",
      "Alwar",
      "Bikaner",
      "Barmer",
      "Banswara",
      "Bharatpur",
      "Baran",
      "Bundi",
      "Bhilwara",
      "Churu",
      "Chittorgarh",
      "Dausa",
      "Dholpur",
      "Dungarpur",
      "Ganganagar",
      "Hanumangarh",
      "Jhunjhunu",
      "Jalore",
      "Jodhpur",
      "Jaipur",
      "Jaisalmer",
      "Jhalawar",
      "Karauli",
      "Kota",
      "Nagaur",
      "Pali",
      "Pratapgarh",
      "Rajsamand",
      "Sikar",
      "Sawai Madhopur",
      "Sirohi",
      "Tonk",
      "Udaipur"
    ]
  },

  // Sikkim (SK) - 4
  {
    "state":"Sikkim",
    "districts":[
      "East Sikkim",
      "North Sikkim",
      "South Sikkim",
      "West Sikkim"
    ]
  },

  // Tamil Nadu (TN) - 38
  {
    "state":"Tamil Nadu",
    "districts":[
      "Ariyalur",
      "Chengalpattu",
      "Chennai",
      "Coimbatore",
      "Cuddalore",
      "Dharmapuri",
      "Dindigul",
      "Erode",
      "Kallakurichi",
      "Kanchipuram",
      "Kanyakumari",
      "Karur",
      "Krishnagiri",
      "Madurai",
      "Mayiladuthurai",
      "Nagapattinam",
      "Nilgiris",
      "Namakkal",
      "Perambalur",
      "Pudukkottai",
      "Ramanathapuram",
      "Ranipet",
      "Salem",
      "Sivaganga",
      "Tenkasi",
      "Tirupur",
      "Tiruchirappalli",
      "Theni",
      "Tirunelveli",
      "Thanjavur",
      "Thoothukudi",
      "Tirupattur",
      "Tiruvallur",
      "Tiruvarur",
      "Tiruvannamalai",
      "Vellore",
      "Viluppuram",
      "Virudhunagar"
    ]
  },

  // Telangana (TG) - 33
  {
    "state":"Telangana",
    "districts":[
      "Adilabad",
      "Komaram Bheem",
      "Bhadradri Kothagudem",
      "Hyderabad",
      "Jagtial",
      "Jangaon",
      "Jayashankar Bhupalpally",
      "Jogulamba Gadwal",
      "Kamareddy",
      "Karimnagar",
      "Khammam",
      "Mahabubabad",
      "Mahbubnagar",
      "Mancherial",
      "Medak",
      "Medchal-Malkajgiri",
      "Mulugu",
      "Nalgonda",
      "Narayanpet",
      "Nagarkurnool",
      "Nirmal",
      "Nizamabad",
      "Peddapalli",
      "Rajanna Sircilla",
      "Ranga Reddy",
      "SangaReddy",
      "Siddipet",
      "Suryapet",
      "Vikarabad",
      "Wanaparthy",
      "Warangal Urban",
      "Warangal Rural",
      "Yadadri Bhuvanagiri"
    ]
  },

  // Tripura (TR) - 8
  {
    "state":"Tripura",
    "districts":[
      "Dhalai",
      "Gomati",
      "Khowai",
      "North Tripura",
      "Sepahijala",
      "South Tripura",
      "Unokoti",
      "West Tripura"
    ]
  },

  // Uttar Pradesh (UP) - 75
  {
    "state":"Uttar Pradesh",
    "districts":[
      "Agra",
      "Aligarh",
      "Prayagraj",
      "Ambedkar Nagar",
      "Amethi",
      "Amroha",
      "Auraiya",
      "Azamgarh",
      "Bagpat",
      "Bahraich",
      "Ballia",
      "Balrampur",
      "Banda",
      "Barabanki",
      "Bareilly",
      "Basti",
      "Bhadohi",
      "Bijnor",
      "Budaun",
      "Bulandshahr",
      "Chandauli",
      "Chitrakoot",
      "Deoria",
      "Etah",
      "Etawah",
      "Ayodhya",
      "Farrukhabad",
      "Fatehpur",
      "Firozabad",
      "Gautam Buddh Nagar",
      "Ghaziabad",
      "Ghazipur",
      "Gonda",
      "Gorakhpur",
      "Hamirpur",
      "Hapur",
      "Hardoi",
      "Hathras",
      "Jalaun",
      "Jaunpur",
      "Jhansi",
      "Kannauj",
      "Kanpur Dehat",
      "Kanpur Nagar",
      "Kasganj",
      "Kaushambi",
      "Kushinagar",
      "Lakhimpur Kheri",
      "Lalitpur",
      "Lucknow",
      "Maharajganj",
      "Mahoba",
      "Mainpuri",
      "Mathura",
      "Mau",
      "Meerut",
      "Mirzapur",
      "Moradabad",
      "Muzaffarnagar",
      "Pilibhit",
      "Pratapgarh",
      "Raebareli",
      "Rampur",
      "Saharanpur",
      "Sambhal",
      "Sant Kabir Nagar",
      "Shahjahanpur",
      "Shamli",
      "Shravasti",
      "Siddharthnagar",
      "Sitapur",
      "Sonbhadra",
      "Sultanpur",
      "Unnao",
      "Varanasi"
    ]
  },

  // Uttarakhand (UT) - 13
  {
    "state":"Uttarakhand",
    "districts":[
      "Almora",
      "Bageshwar",
      "Chamoli",
      "Champawat",
      "Dehradun",
      "Haridwar",
      "Nainital",
      "Pauri Garhwal",
      "Pithoragarh",
      "Rudraprayag",
      "Tehri Garhwal",
      "Udham Singh Nagar",
      "Uttarkashi"
    ]
  },

  // West Bengal (WB) - 23
  {
    "state":"West Bengal",
    "districts":[
      "Alipurduar",
      "Bankura",
      "Paschim Bardhaman",
      "Purba Bardhaman",
      "Birbhum",
      "Cooch Behar",
      "Dakshin Dinajpur",
      "Darjeeling",
      "Hooghly",
      "Howrah",
      "Jalpaiguri",
      "Jhargram",
      "Kalimpong",
      "Kolkata",
      "Maldah",
      "Murshidabad",
      "Nadia",
      "North 24 Parganas",
      "Paschim Medinipur",
      "Purba Medinipur",
      "Purulia",
      "South 24 Parganas",
      "Uttar Dinajpur"
    ]
  },
];
}