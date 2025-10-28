import 'dart:typed_data';

class TestFixtures {
  static Uint8List validCardResponse() {
    final response = Uint8List(253);
    for (var i = 0; i < 10; i++) {
      response[i] = 0x00;
    }
    response[10] = 0x00;
    response[11] = 0x00;
    response[12] = 15;
    return response;
  }

  static Uint8List shortCardResponse() {
    return Uint8List(10);
  }

  static Uint8List errorStatusResponse() {
    final response = Uint8List(253);
    response[10] = 0x01;
    response[11] = 0x00;
    response[12] = 0;
    return response;
  }

  static Uint8List sampleJourneyBlock() {
    final block = Uint8List(16);
    block[0] = 0x00;
    block[1] = 0x01;
    block[2] = 0x02;
    block[3] = 0x03;
    block[4] = 0x64;
    block[5] = 0x00;
    block[6] = 0x00;
    block[7] = 0x00;
    block[8] = 0x0A;
    block[9] = 0x00;
    block[10] = 0x5F;
    block[11] = 0x13;
    block[12] = 0x88;
    block[13] = 0x00;
    block[14] = 0x00;
    block[15] = 0x00;
    return block;
  }

  static Uint8List sampleTopupBlock() {
    final block = Uint8List(16);
    block[0] = 0x00;
    block[1] = 0x01;
    block[2] = 0x02;
    block[3] = 0x03;
    block[4] = 0x64;
    block[5] = 0x00;
    block[6] = 0x01;
    block[7] = 0x00;
    block[8] = 0x0A;
    block[9] = 0x00;
    block[10] = 0x00;
    block[11] = 0x27;
    block[12] = 0x10;
    block[13] = 0x00;
    block[14] = 0x00;
    block[15] = 0x00;
    return block;
  }
}
