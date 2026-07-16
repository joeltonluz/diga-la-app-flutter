import '../models/card.dart';
import '../models/category.dart';

const List<Category> sampleCategories = [
  Category(
    id: 'animais',
    name: 'Animais',
    icon: '🐾',
    items: [
      Card(id: 'cachorro', labelPt: 'cachorro', labelEn: 'dog', emoji: '🐶'),
      Card(id: 'gato', labelPt: 'gato', labelEn: 'cat', emoji: '🐱'),
      Card(id: 'passaro', labelPt: 'pássaro', labelEn: 'bird', emoji: '🐦'),
      Card(id: 'peixe', labelPt: 'peixe', labelEn: 'fish', emoji: '🐟'),
      Card(id: 'cavalo', labelPt: 'cavalo', labelEn: 'horse', emoji: '🐴'),
    ],
  ),
  Category(
    id: 'frutas',
    name: 'Frutas',
    icon: '🍎',
    items: [
      Card(id: 'maca', labelPt: 'maçã', labelEn: 'apple', emoji: '🍎'),
      Card(id: 'banana', labelPt: 'banana', labelEn: 'banana', emoji: '🍌'),
      Card(id: 'laranja', labelPt: 'laranja', labelEn: 'orange', emoji: '🍊'),
      Card(id: 'uva', labelPt: 'uva', labelEn: 'grape', emoji: '🍇'),
      Card(id: 'morango', labelPt: 'morango', labelEn: 'strawberry', emoji: '🍓'),
    ],
  ),
  Category(
    id: 'transportes',
    name: 'Transportes',
    icon: '🚗',
    items: [
      Card(id: 'carro', labelPt: 'carro', labelEn: 'car', emoji: '🚗'),
      Card(id: 'onibus', labelPt: 'ônibus', labelEn: 'bus', emoji: '🚌'),
      Card(id: 'aviao', labelPt: 'avião', labelEn: 'airplane', emoji: '✈️'),
      Card(id: 'bicicleta', labelPt: 'bicicleta', labelEn: 'bicycle', emoji: '🚲'),
      Card(id: 'barco', labelPt: 'barco', labelEn: 'boat', emoji: '⛵'),
    ],
  ),
  Category(
    id: 'partes-do-corpo',
    name: 'Partes do Corpo',
    icon: '🖐️',
    items: [
      Card(id: 'cabeca', labelPt: 'cabeça', labelEn: 'head', emoji: '👤'),
      Card(id: 'mao', labelPt: 'mão', labelEn: 'hand', emoji: '🤚'),
      Card(id: 'pe', labelPt: 'pé', labelEn: 'foot', emoji: '🦶'),
      Card(id: 'olho', labelPt: 'olho', labelEn: 'eye', emoji: '👁️'),
      Card(id: 'boca', labelPt: 'boca', labelEn: 'mouth', emoji: '👄'),
    ],
  ),
  Category(
    id: 'cores',
    name: 'Cores',
    icon: '🎨',
    items: [
      Card(id: 'vermelho', labelPt: 'vermelho', labelEn: 'red', emoji: '🔴'),
      Card(id: 'azul', labelPt: 'azul', labelEn: 'blue', emoji: '🔵'),
      Card(id: 'amarelo', labelPt: 'amarelo', labelEn: 'yellow', emoji: '🟡'),
      Card(id: 'verde', labelPt: 'verde', labelEn: 'green', emoji: '🟢'),
    ],
  ),
];
