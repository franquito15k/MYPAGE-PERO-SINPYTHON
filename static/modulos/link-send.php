<main style="width: 90%; overflow-y: hidden;">
    <div class="recuadros">
        <section class="flex column align-items-center">
            <h3>Descargar Video de Youtube</h3>
            <form class="flex row justify-row" id="download-form" method="POST">
                <div>
                    <label for="video-url">Pegar alado la URL: </label>
                </div>
                <div>
                    <input type="text" name="video-url" id="video-url" placeholder="Pegar el enlace aquí..." required>
                </div>
                <div>
                    <button type="submit">Obtener el video del enlace</button>
                </div>
            </form>
        </section>
        <img src="./static/img/loadingcat.jpg" alt="loading gif" id="loadingGif" style="display: none;">
        <section class="flex column align-items-center justify-content-center">
            <h2>Instant Download - El mejor descargador de mp4 de Youtube 2024</h2>
            <p>"Youtube to Video" es una herramienta que permite descargar videos de Youtube rápidamente y en diversos formatos, como MP4, sin necesidad de conversión de audio.</p>
        </section>

        <section class="flex column align-items-center justify-content-center">
            <h2>Cómo descargar mp3 de Youtube más rápido</h2>
            <div class="flex row justify-content-center" id="tablet-query">
                <div class="flex row" id="text-img">
                    <img src="./static/img/link-solid.png" alt="link-image" width="32" height="32">
                    <div>Pegue el enlace convertir YouTube a MP3 en el cuadro de búsqueda</div>
                </div>
                <div class="flex row" id="text-img">
                    <img src="./static/img/settings.png" alt="configurator-image" width="32" height="32">
                    <div>Haga clic en el botón "Obtener video del enlace"</div>
                </div>
            </div>
        </section>
    </div>
</main>

<script>
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
</script>