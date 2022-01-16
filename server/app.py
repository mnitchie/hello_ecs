import os
import logging

from flask import Flask

logger = logging.getLogger('gunicorn.error')

app = Flask(__name__)

print("We have an app")

app.config["FLASK_ENV"] = os.getenv("FLASK_ENV")
app.config["SERVER_NAME"] = ":".join(
    [
        # os.getenv("FLASK_URL", "localhost.localdomain"),
        # "localhost",
        "helloecs_flask",
        os.getenv("FLASK_PORT", "6701"),
    ]
)

logger.error(f"{app.config['SERVER_NAME']}")

# TODO: Need this?
hostname = app.config["SERVER_NAME"]

logger.error("doin stuff")

@app.route("/api")
def getIt():
    return "Sup?!", 200

logger.error("doin stuff again")

@app.route("/")
def wat():
    return "Sup?!!!!", 200


if __name__ == "__main__":
    app.run()
