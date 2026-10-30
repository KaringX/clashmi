import 'package:flutter/services.dart';
import 'package:clashmi/app/utils/log.dart';

abstract final class RulesetCodesUtils {
  static final List<String> _sp = ["\r\n", "\n"];
  static List<int>? _siteCodesHashCode;
  static List<int>? _ipCodesHashCode;

  static Future<List<String>> _getCodes(String key) async {
    List<String> codes = [];
    try {
      String content = await rootBundle.loadString(key, cache: false);
      for (var s in _sp) {
        if (content.contains(s)) {
          codes = content.split(s);
          break;
        }
      }

      for (var code in codes) {
        code = code.trim();
      }
      codes.removeWhere((ele) => ele == "");
    } catch (err) {
      Log.w("load $key exception: ${err.toString()}");
    }
    return codes;
  }

  static Future<List<String>> siteCodes() async {
    return _getCodes("assets/datas/geosite_codes.txt");
  }

  static Future<List<int>> siteCodesHashCode() async {
    if (_siteCodesHashCode == null) {
      List<String> codes = await siteCodes();
      _siteCodesHashCode = List<int>.filled(codes.length, 0, growable: false);
      for (int i = 0; i < codes.length; ++i) {
        _siteCodesHashCode![i] = (codes[i].hashCode);
      }
    }
    return _siteCodesHashCode!;
  }

  static Future<List<String>> ipCodes() async {
    return _getCodes("assets/datas/geoip_codes.txt");
  }

  static Future<List<int>> ipCodesHashCode() async {
    if (_ipCodesHashCode == null) {
      List<String> codes = await ipCodes();
      _ipCodesHashCode = List<int>.filled(codes.length, 0, growable: false);
      for (int i = 0; i < codes.length; ++i) {
        _ipCodesHashCode![i] = (codes[i].hashCode);
      }
    }
    return _ipCodesHashCode!;
  }
}
