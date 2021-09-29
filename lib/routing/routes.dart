const rootRoute = "/";

const introductionPageDisplayName = "基本簡介";
const introductionPageRoute = "/introduction";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const driversPageDisplayName = "Drivers";
const driversPageRoute = "/drivers";

const clientsPageDisplayName = "Clients";
const clientsPageRoute = "/clients";

//const covid19PageDisplayName = "Covid-19";
//const covid19PageRoute = "/covid19";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(introductionPageDisplayName, introductionPageRoute),
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(driversPageDisplayName, driversPageRoute),
  MenuItem(clientsPageDisplayName, clientsPageRoute),
//  MenuItem(covid19PageDisplayName, covid19PageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
