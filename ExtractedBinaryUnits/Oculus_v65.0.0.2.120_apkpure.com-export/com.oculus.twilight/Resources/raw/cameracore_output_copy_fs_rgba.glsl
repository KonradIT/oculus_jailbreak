precision mediump float; // highp here doesn't seem to matter

uniform sampler2D sTexture;

varying vec2 vTextureCoord;

void main() {
  gl_FragColor = texture2D(sTexture, vTextureCoord).rgba;
}