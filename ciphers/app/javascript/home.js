const inputType = document.getElementById("input_type");

inputType.addEventListener("change", (e) => {
  // Modifiy input field to match the selected type
  const inputField = document.getElementById("input_field");
  if (e.target.value === "text") {
    inputField.innerHTML = `<label for="input_text">Input text:</label>
    <textarea id="input_text" rows="5" cols="60" name="input_text"></textarea>`;
  } else if (e.target.value === "file") {
    inputField.innerHTML = `<label for="input_file">Input file:</label>
    <input type="file" id="input_file" name="input_file">`;
  }
});
