from flask import Flask, json, render_template, request
from tb_detection_model import TBDetectionModel
import os
from flask_cors import CORS


app = Flask(__name__)

CORS(app)
# Load model
MODEL_PATH = r"E:\SachinProject (1)\ChextXRay\tb_detect\tb_detect\tb_model.h5"
tb_model = TBDetectionModel(model_path=MODEL_PATH)

# Uploads folder
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

            
            prediction, confidence = tb_model.predict(filepath)  # returns a dict

            # Convert to Python native types if needed
            if hasattr(prediction, "tolist"):
                prediction = prediction.tolist()
            if hasattr(confidence, "tolist"):
                confidence = confidence.tolist()
                

    return json.jsonify({
        "result": prediction,
        "confidence": confidence
    })


if __name__ == "__main__":
    app.run(debug=True)