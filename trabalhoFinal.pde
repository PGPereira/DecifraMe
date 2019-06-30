int maxScore = 3;
int score;
int scene = -1;
int sceneQuantity = 3;

class buttomBasic{
  String text;
  boolean valid;

  buttomBasic(String t, boolean v){
    this.text = t;
    this.valid = v;
  }
}

class frame{
  PImage background;
  box textBox;

  void click(float x, float y){
    textBox.click(x, y);
  }

  void render(){
    image(background, 0, 0);
    textBox.render();
  }

  frame(String imagePath, String text, buttomBasic[] bB){
    this.background = loadImage(imagePath);
    this.textBox = new box(0 + width*0.05, height * 2/3, width*0.9, height/3, text, bB);
  }

  frame(PImage image, String text, buttomBasic[] bB){
    this.background = image;
    this.textBox = new box(0 + width*0.05, height * 2/3, width*0.9, height/3, text, bB);
  }

  frame(String imagePath){
    this.background = loadImage(imagePath);
  }
}

class box{
  float x, y, h, w;
  String text;
  buttom[] buttons;

  void render(){
    fill(#EDE886, 180);
    rect(x, y, w, h);
    fill(0);
    text(text, x + w * (0.05), y + h * (0.05), w * 0.9, h * 0.9);
    for(buttom b : buttons){
      b.render();
    }
  }

  void click(float x, float y){
    for(buttom b : buttons){
      b.click(x, y);
    }
  }

  box(float x, float y, float w, float h, String t, buttomBasic[] b){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = t;
    this.buttons = new buttom[b.length];
    int k = b.length;
    for(int i = 0; i < k; i++){
      buttons[i] = new buttom(
        b[i].text,
        x + (w/k) * i + (w/k)*0.05,
        y + h * 0.75,
        (w/k) * 0.9,
        h * 0.20,
        b[i].valid
      );
    }
  }
}

class buttom{
  float x, y, h, w;
  String text;
  boolean isCorrect;

  boolean clickIsInside(float x, float y){
    return ((x >= this.x && x <= (this.x + this.w)) && (y >= this.y && y <= (this.y + this.h)));
  }

  void click(float x, float y){
    if(clickIsInside(x, y)){
      scene++;
      if (this.isCorrect){
        score++;
      }
    }
  }

  void render(){
    fill(#CBC99A, 20);
    rect(x, y, w, h, min(w,h) * 0.2);
    fill(0);
    text(text, x + w * (0.05), y + h * (0.05), w * 0.9, h * 0.9);
  }

  buttom(String text, float x, float y, float w, float h, boolean isCorrect){
    this.text = text;
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    this.isCorrect = isCorrect;
  }
}

PImage title, sphynx, end1, end2, end;
frame[] scenes;


void setup(){
  textSize(28);
  size(1080, 720);
  scenes = new frame[sceneQuantity];
  String[] enigma = new String[sceneQuantity];
  score = 0;
  title = loadImage("assets/title.png");
  sphynx = loadImage("assets/sphynx.png");
  end = loadImage("assets/end.png");
  end1 = loadImage("assets/end1.png");
  end2 = loadImage("assets/end2.png");

  title.resize(width, height);
  sphynx.resize(width, height);
  end.resize(width, height);
  end1.resize(width, height);
  end2.resize(width, height);

  buttomBasic[][] buttons = new buttomBasic[sceneQuantity][];
  buttons[0]= new buttomBasic[]{
      new buttomBasic("curso d’água", false),
      new buttomBasic("tempo", true),
      new buttomBasic("Deus", false),
      new buttomBasic("amor", false)
  };

  buttons[1] = new buttomBasic[]{
      new buttomBasic("guerra", false),
      new buttomBasic("difamação", false),
      new buttomBasic("morte", false),
      new buttomBasic("medo", true)
  };

  buttons[2] = new buttomBasic[]{
      new buttomBasic("o vazio", false),
      new buttomBasic("tristeza", false),
      new buttomBasic("o nada", true),
      new buttomBasic("humanidade", false)
  };



  enigma[0] = "Estou desde o começo e irei ate o fim. Eu sempre sigo em frente. Nem o mais rico dos homens pode me comprar. O que sou?";
  enigma[1] = "Todos fogem de mim. Eu estou no escuro. Venho com o estrangeiro. Estou nas multidões e estou no amanhã. Quem sou eu?";
  enigma[2] = "É mais poderoso que os deuses. Mais maligno que os demônios. É algo que os pobres têm, e os ricos precisam. Se você o comer, morre. O que é isso?";

  for(int i = 0; i < sceneQuantity; i++){
      scenes[i] = new frame(sphynx, enigma[i], buttons[i]);
  }
}

void draw(){
  if(scene < 0){
    image(title, 0, 0);
  } else if (scene < sceneQuantity){
     scenes[scene].render();
  } else if(scene == sceneQuantity){
    if(score < maxScore/2){
      image(end1, 0, 0);
    } else {
      image(end2, 0, 0);
    }
  } else if (scene == (sceneQuantity + 1)){
    image(end, 0, 0);
  }

  println(scene);
}

void mouseClicked(){
  if(scene < 0){
    scene++;
  } else if (scene < sceneQuantity){
     scenes[scene].click(mouseX, mouseY);
  } else if(scene == sceneQuantity ){
    scene++;
  } else if (scene == sceneQuantity + 1){
    scene = -1;
    score = 0;
  }
}
