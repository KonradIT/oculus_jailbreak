attribute vec4 aPosition;
attribute vec4 aTextureCoord;

uniform mat4 uSTMatrix;
uniform mat4 uConstMatrix;
uniform mat4 uContentTransform;

varying vec2 vTextureCoord;

void main() {
  gl_Position = uContentTransform * aPosition;
  vTextureCoord = (uSTMatrix * uConstMatrix * aTextureCoord).xy;
}
