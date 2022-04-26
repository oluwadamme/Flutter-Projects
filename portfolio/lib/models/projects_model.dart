class ProjectModel {
  final String? title, description, url;
  final String? images;

  ProjectModel({this.title, this.description, this.url, this.images});
}

List<ProjectModel> demo_projects = [
  ProjectModel(
    title: "EtrackPay",
    description: "An energy smart prepaid meter payment app for estate tenants",
    url:
        'https://play.google.com/store/apps/details?id=com.etracksystems.etracktenant',
    images: 'assets/images/etrack 1.png',
  ),
  ProjectModel(
    title: "MonyPot",
    description: "A crypto currency app to take personal loan.",
    url:
        'https://play.google.com/store/apps/details?id=com.monypot.monypot_mobile',
    images: 'assets/images/monypot 1.png',
  ),
  ProjectModel(
    title: "MojecPay",
    description:
        "An electricity token vending app for postpaid and prepaid meter users.",
    url: 'https://github.com/oluwadamme/MojecPay',
    images: 'assets/images/mojec1.png',
  ),
  ProjectModel(
    title: "Notify App",
    description:
        "A scheduling and todo app interfaced with flutter local notication option",
    url: 'https://github.com/oluwadamme/Flutter-Projects/tree/main/notify_app',
    images: 'assets/images/note.png',
  ),
  ProjectModel(
    title: "Smart Meter App",
    description:
        "An energy smart prepaid meter payment app. It is for a final year ProjectModel",
    url: 'https://github.com/oluwadamme/Flutter-Projects/tree/main/esl_tarriff',
    images: 'assets/images/smart.jpg',
  ),
  ProjectModel(
    title: "StartHub",
    description:
        "An open source Project that connects people that are interested in tech for training and mentor",
    url: 'https://github.com/oluwadamme/starthub_mobile_pjt_02',
    images: 'assets/images/starthub.png',
  ),
  ProjectModel(
    title: "ZuriChat",
    description:
        "An open source Project where people in a team can connect and communicate. it is like a slack clone",
    url: 'https://github.com/oluwadamme/zc_app',
    images: 'assets/images/zuri.png',
  )
];
