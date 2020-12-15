uniform mat4 uSceneTransformMatrix;

attribute vec4 aPosition;

void main() {
  gl_Position = uSceneTransformMatrix * aPosition;
}
