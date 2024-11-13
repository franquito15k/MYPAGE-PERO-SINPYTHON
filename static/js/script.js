document.getElementById('download-form').addEventListener('submit', async function (event) {
  event.preventDefault();

  const url = document.getElementById('video-url').value;
  const messageDiv = document.getElementById('message');

  try {
    const response = await fetch('http://localhost:5000/download', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: new URLSearchParams({ url: url })
    });

    if (response.ok) {
      const data = await response.json();
      messageDiv.textContent = data.message;
    } else {
      messageDiv.textContent = 'Error al descargar el video.';
    }
  } catch (error) {
    messageDiv.textContent = 'Error al conectar con el servicio de descarga.';
  }
});