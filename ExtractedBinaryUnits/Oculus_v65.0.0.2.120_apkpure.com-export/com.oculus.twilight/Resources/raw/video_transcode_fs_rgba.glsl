#extension GL_OES_EGL_image_external : require

precision mediump float; // highp here doesn't seem to matter

uniform samplerExternalOES sTexture;

varying vec2 vTextureCoord;

void main() {
  gl_FragColor = texture2D(sTexture, vTextureCoord).rgba;
}