import 'dart:io';

import 'package:dio/dio.dart';

import '../response.dart';
import '../result.dart';

Future<Result<T>> safeApiCall<T>({
  required Future<Response> Function() request,
  required T Function(dynamic data) parse,
  Future<void> Function(T data)? onSuccess,
}) async {
  try {
    final response = await request();

    if (response.data is String &&
        (response.data.contains('<html') ||
            response.data.contains('<!DOCTYPE html'))) {
      return Result.failed("Terjadi kesalahan pada server. Data tidak valid.");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      final parsedData = parse(response.data);

      if (onSuccess != null) {
        await onSuccess(parsedData);
      }

      return Result.success(parsedData);
    }

    return Result.failed("Gagal: ${response.statusCode} ${response.data}");
  } on DioException catch (e) {
    String errorMessage = "Terjadi kesalahan, silakan coba lagi.";

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      rethrow;
    }

    if (e.response != null) {
      final statusCode = e.response?.statusCode ?? 0;
      final responseData = e.response?.data;

      errorMessage = parseErrorResponse(responseData);

      if (statusCode == 500) {
        return Result.failed(
          "${errorMessage.isNotEmpty ? errorMessage : 'Internal Server Error'} (error code 500)",
        );
      }
    } else if (e.message != null) {
      errorMessage = e.message!;
    }

    return Result.failed(errorMessage);
  } on HandshakeException catch (_) {
    return Result.failed(
      "Gagal terhubung karena sertifikat server tidak valid. Silakan hubungi tim teknis.",
    );
  } on SocketException catch (_) {
    return Result.failed(
      "Tidak ada koneksi internet atau server tidak dapat dijangkau.",
    );
  } catch (e) {
    return Result.failed("Terjadi kesalahan tidak terduga: $e");
  }
}
