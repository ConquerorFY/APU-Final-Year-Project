class Validator {
  // Profile
  final nameRegExp = RegExp(r'^[a-zA-Z ]+$');
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  final stateRegExp = RegExp(r'^[A-Z]{1}[a-zA-Z ]+$');
  final cityRegExp = RegExp(r'^[A-Z]{1}[a-zA-Z ]+$');
  final postcodeRegExp = RegExp(r'^[0-9]+$');
  final streetRegExp = RegExp(r'^[a-zA-Z0-9\/ ]+$');
  final contactRegExp = RegExp(r'^[0-9-]+$');
  final usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,16}$');
  final passwordRegExp = RegExp(r'^[a-zA-Z0-9()_\/]{8,}$');
  // Post
  final dateRegExp = RegExp(r'^[0-9]{4}-[0-1][0-9]-[0-3][0-9]$');
  final timeRegExp = RegExp(r'^[0-2][0-9]:[0-5][0-9]:[0-5][0-9]$');
  final titleRegExp = RegExp(r'^[a-zA-Z0-9 ]+$');
  final descriptionRegExp = RegExp(r'^[a-zA-Z0-9 ]+$');
  final actionRegExp = RegExp(r'^[a-zA-Z0-9 ]+$');

  // Private constructor to prevent external instantiation
  Validator._();
  // Singleton instance
  static final Validator _instance = Validator._();
  // Factory method to retrieve the instance
  factory Validator() => _instance;

  validateName(name) {
    if (name!.isEmpty) {
      return 'Please enter an name!';
    }
    if (!nameRegExp.hasMatch(name)) {
      return 'Please enter a valid name!';
    }
    return null;
  }

  validateEmail(email) {
    if (email!.isEmpty) {
      return 'Please enter a email!';
    }
    if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email!';
    }
    return null;
  }

  validateState(state) {
    if (state!.isEmpty) {
      return 'Please enter a state!';
    }
    if (!stateRegExp.hasMatch(state)) {
      return 'Please enter a valid state!';
    }
    return null;
  }

  validateCity(city) {
    if (city!.isEmpty) {
      return 'Please enter a city!';
    }
    if (!cityRegExp.hasMatch(city)) {
      return 'Please enter a valid city!';
    }
    return null;
  }

  validatePostcode(postcode) {
    if (postcode!.isEmpty) {
      return 'Please enter a postcode!';
    }
    if (!postcodeRegExp.hasMatch(postcode)) {
      return 'Please enter a valid postcode!';
    }
    return null;
  }

  validateStreet(street) {
    if (street!.isEmpty) {
      return 'Please enter a street!';
    }
    if (!streetRegExp.hasMatch(street)) {
      return 'Please enter a valid street!';
    }
    return null;
  }

  validateContact(contact) {
    if (contact!.isEmpty) {
      return 'Please enter a contact!';
    }
    if (!contactRegExp.hasMatch(contact)) {
      return 'Please enter a valid contact!';
    }
    return null;
  }

  validateUsername(username) {
    if (username!.isEmpty) {
      return 'Please enter a username!';
    }
    if (!usernameRegExp.hasMatch(username)) {
      return 'Please enter a valid username!';
    }
    return null;
  }

  validatePassword(password) {
    if (password!.isEmpty) {
      return 'Please enter a password!';
    }
    if (!passwordRegExp.hasMatch(password)) {
      return 'Please enter a valid password!';
    }
    return null;
  }

  validateDate(date) {
    if (date!.isEmpty) {
      return 'Please enter a date!';
    }
    if (!dateRegExp.hasMatch(date)) {
      return 'Please enter a valid date!';
    }
    return null;
  }

  validateTime(time) {
    if (time!.isEmpty) {
      return 'Please enter a time!';
    }
    if (!timeRegExp.hasMatch(time)) {
      return 'Please enter a valid time!';
    }
    return null;
  }

  validateTitle(title) {
    if (title!.isEmpty) {
      return 'Please enter a title!';
    }
    if (!titleRegExp.hasMatch(title)) {
      return 'Please enter a valid title!';
    }
    return null;
  }

  validateDescription(description) {
    if (description!.isEmpty) {
      return 'Please enter a description!';
    }
    if (!descriptionRegExp.hasMatch(description)) {
      return 'Please enter a valid description!';
    }
    return null;
  }

  validateAction(action) {
    if (action!.isEmpty) {
      return 'Please enter a action!';
    }
    if (!actionRegExp.hasMatch(action)) {
      return 'Please enter a valid action!';
    }
    return null;
  }
}
