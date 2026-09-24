class StackTraceUtils {
  static String trim(StackTrace stackTrace, int? depth) {
    String stack = stackTrace
        .toString()
        .split("\n")
        .take(depth ?? 5)
        .join("\n");
    return stack;
  }
}
