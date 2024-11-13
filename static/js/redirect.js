// redirect.js

function redirectToVideo(videoId) {
    setTimeout(function() {
        window.location.href = `http://127.0.0.1:5000/video/${videoId}`;
    }, 10000);
}