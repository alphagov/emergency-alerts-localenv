import json
from http.server import BaseHTTPRequestHandler, HTTPServer


class LambdaHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        # Check if path feels Lambda-ey
        if self.path.startswith("/2015-03-31/functions/") and self.path.endswith(
            "/invocations"
        ):
            response_payload = {
                "StatusCode": 200,
                "ExecutedVersion": "$LATEST",
                "Payload": {
                    "message": "This is a fake Lambda response",
                    "success": True,
                },
            }
            response_data = json.dumps(response_payload).encode("utf-8")

            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(response_data)))
            self.end_headers()
            self.wfile.write(response_data)
        else:
            # Return 404 for other paths
            self.send_response(404)
            self.end_headers()


def run(server_class=HTTPServer, handler_class=LambdaHandler, port=5000):
    print(f"Starting simulated Lambda API on port {port}...")
    server_address = ("0.0.0.0", port)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()


if __name__ == "__main__":
    run()
