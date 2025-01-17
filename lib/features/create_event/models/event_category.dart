enum EventCategory {
  conferences('Conferences'),
  workshops('Workshops'),
  seminars('Seminars'),
  webinars('Webinars'),
  tradeShows('Trade Shows'),
  festivals('Festivals'),
  fundraisers('Fundraisers'),
  parties('Parties'),
  sportsEvents('Sports Events'),
  exhibitions('Exhibitions'),
  concerts('Concerts'),
  meetups('Meetups'),
  productLaunches('Product Launches'),
  corporateEvents('Corporate Events');

  final String name;
  const EventCategory(this.name);
  @override
  String toString() => name;
  static List<String> getNames() {
    return EventCategory.values.map((e) => e.name).toList();
  }
}
