String parseErrorResponse(dynamic responseData) {
  if (responseData == null) {
    return "Terjadi kesalahan, silakan coba lagi.";
  }

  String errorMessage = "Terjadi kesalahan, silakan coba lagi.";
  List<String> details = [];

  if (responseData is Map) {
    final message = responseData['status_message'];
    final error = responseData['error'];
    final errors = responseData['errors'];

    if (error is String) {
      details.add(error);
    }

    if (error is Map<String, dynamic>) {
      final statusCode = error['status_code'];
      final statusMessage = error['status_message'];

      if (statusCode != null && statusMessage != null) {
        details.add("Kode Error: $statusCode");
        details.add("Pesan: $statusMessage");
      } else {
        error.forEach((key, value) {
          details.add("$key : $value");
        });
      }
    }

    if (errors is Map<String, dynamic>) {
      errors.forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          details.add("$key : ${value.first}");
        } else {
          details.add("$key : $value");
        }
      });
    }

    if (message != null && message is String) {
      errorMessage = message;
      if (details.isNotEmpty) {
        errorMessage += "\n${details.join('\n')}";
      }
    } else if (details.isNotEmpty) {
      errorMessage = details.join('\n');
    }
  } else {
    errorMessage = responseData.toString();
  }

  return errorMessage;
}
