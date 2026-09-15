import { createFileRoute } from "@tanstack/react-router";
import { Play, Volume2 } from "lucide-react";

import { Button } from "@/components/ui/button";

export const Route = createFileRoute("/")({
  component: Index,
});

function Index() {
  return (
    <main className="story-shell">
      <section className="story-intro">
        <p className="eyebrow">Hello Hub · História narrada</p>
        <h1>O que uma mãe perdeu, e o que nunca perdeu</h1>
        <p className="intro-copy">
          Uma narrativa visual em formato vertical, com as cenas de Maria e Daniel animadas para
          acompanhar cada momento da narração original.
        </p>
        <div className="story-meta" aria-label="Informações do vídeo">
          <span>9:16 vertical</span>
          <span>1080 × 1920 HD</span>
          <span>4 min 43 s</span>
        </div>
      </section>

      <section className="video-card" aria-label="Vídeo narrado de Maria e Daniel">
        <div className="video-glow" />
        <div className="video-frame">
          <video
            controls
            playsInline
            preload="metadata"
            poster="/favicon.ico"
            aria-label="Vídeo narrado da história de Maria e Daniel"
          >
            <source src="/maria-daniel-narrado-9x16.mp4" type="video/mp4" />
            Seu navegador não suporta a reprodução de vídeo.
          </video>
          <div className="video-badge">
            <Play size={14} fill="currentColor" />
            <span>Reprodução com narração</span>
          </div>
        </div>
        <div className="video-caption">
          <div>
            <p className="caption-label">A história de Maria</p>
            <p className="caption-subtitle">Cenas animadas · áudio original</p>
          </div>
          <Volume2 size={20} aria-hidden="true" />
        </div>
      </section>

      <section className="story-footer">
        <p>“Vergiss niemals die Hände, die dich großgezogen haben.”</p>
        <Button asChild variant="outline" className="download-button">
          <a href="/maria-daniel-narrado-9x16.mp4" download>
            Baixar vídeo MP4
          </a>
        </Button>
      </section>
    </main>
  );
}

export default Index;
