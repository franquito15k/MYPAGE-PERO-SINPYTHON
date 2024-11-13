document.getElementById('download-form').addEventListener('submit', async function(event) {
  event.preventDefault();

  const url = document.getElementById('video-url').value;
  const loadingGif = document.getElementById('loadingGif');
  loadingGif.style.display = 'block';

  try {
      const response = await fetch('http://localhost:5000/download', {
          method: 'POST',
          headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: new URLSearchParams({
              url: url
          })
      });

      if (response.ok) {
          const data = await response.json();
          if (data.idDescarga) {
              window.location.href = `http://127.0.0.1:5000/video/${data.idDescarga}`;
          } else {
              alert('Error al obtener el ID del video.');
          }
      } else {
          alert('Error al descargar el video.');
      }
  } catch (error) {
      alert('Error al conectar con el servicio de descarga.');
  } finally {
      loadingGif.style.display = 'none';
  }
});