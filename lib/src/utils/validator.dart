class Validator {
  static String? validateField({required String value}) {
    if (value.isEmpty) {
      return 'El área de texto no puede estar vacía';
    }

    return null;
  }

  static String? validateUserID({required String uid}) {
    if (uid.isEmpty) {
      return 'El usuario no puede quedar vacío';
    } else if (uid.length <= 3) {
      return 'El nombre de usuario debe ser mayor a 3 caracteres';
    }

    return null;
  }
}
