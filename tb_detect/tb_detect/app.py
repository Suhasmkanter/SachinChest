from flask import Flask, json, request
from tb_detection_model import TBDetectionModel
import os
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Load model from container path (relative path)
MODEL_PATH = os.path.join(os.getcwd(), "tb_model.h5")  # Place your model in tb_detect/tb_detect folder
tb_model = TBDetectionModel(model_path=MODEL_PATH)

# Uploads folder inside container
UPLOAD_FOLDER = os.path.join(os.getcwd(), "uploads")
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route("/", methods=["GET", "POST"])
def index():
    prediction = None
    confidence = None

    if request.method == "POST":
        file = request.files.get("file")
        if file:
            filepath = os.path.join(UPLOAD_FOLDER, file.filename)
            file.save(filepath)

            prediction, confidence = tb_model.predict(filepath)

            # Convert numpy arrays to lists if needed
            if hasattr(prediction, "tolist"):
                prediction = prediction.tolist()
            if hasattr(confidence, "tolist"):
                confidence = confidence.tolist()

    return json.jsonify({
        "result": prediction,
        "confidence": confidence
    })

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))  # Use Render's PORT variable
    app.run(host="0.0.0.0", port=port)
