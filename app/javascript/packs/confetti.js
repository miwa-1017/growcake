function startConfetti() {
  const confettiContainer = document.getElementById("confetti");
  if (!confettiContainer) return;

  document.querySelectorAll(".confetti-piece").forEach(el => el.remove());

    const stage = Number(confettiContainer.dataset.stage);
    const max = Number(confettiContainer.dataset.max);


   // final stage ONLY
  if (stage !== max) {
    console.log("🎀 Not final stage → stop confetti");
    return; 
  }

  console.log("🎉 Final stage reached → confetti START!");

  // ------------------- ここから実行処理 -------------------

  const duration = 10000; // 演出の長さ
  const endTime = Date.now() + duration;

  const colors = ["#ffb6c1", "#ffe066", "#a3e4ff", "#e2a9ff", "#fff66a"];

  function addPiece() {
    const piece = document.createElement("div");
    piece.classList.add("confetti-piece");

    const size = Math.random() * 8 + 4;
    piece.style.width = `${size}px`;
    piece.style.height = `${size * 0.5}px`;

    piece.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
    piece.style.left = Math.random() * 100 + "vw";
    piece.style.animationDuration = 3 + Math.random() * 2 + "s";

    confettiContainer.appendChild(piece);

    setTimeout(() => piece.remove(), 6000);
  }

  function loop() {
    addPiece();
    if (Date.now() < endTime) {
      requestAnimationFrame(loop);
    }
  }

  loop();

  // ------------------- 実行処理ここまで -------------------
}

// ブラウザとturbolinks両対応
document.addEventListener("turbolinks:load", startConfetti);