const inputType = document.getElementById("input-type");

inputType.addEventListener("change", (e) => {
  // Modifiy input field to match the selected type
  const inputField = document.getElementById("input-field");
  if (e.target.value === "text") {
    inputField.innerHTML = `<label for="plaintext-input">Input text:</label>
    <textarea id="plaintext-input" rows="5" cols="60"></textarea>`;
  } else if (e.target.value === "file") {
    inputField.innerHTML = `<label for="file-input">Input file:</label>
    <input type="file" id="file-input" name="file-input">`;
  }
});
