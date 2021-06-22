import 'package:wepark/utils/extensions/location_data_ext.dart';

class WeParkParkingSpaces{
  // static Map<String, Object> _sqaure1 = {'top':32.11795,'left':34.81906,'bottom':32.11614,'right':34.8212,'averageWaitingTime_q':(0.3333333333333333*60)};
  // static Map<String, Object> _sqaure2 = {'top':32.11795,'left':34.69,'bottom':32.11614,'right':34.81906,'averageWaitingTime_q':(0.3333333333333333*60)};
  // static Map<String, Object> _sqaure3 = {'top':32.11795,'left':34.81474,'bottom':32.11614,'right':34.8169,'averageWaitingTime_q':(0.3333333333333333*60)};



  static List<MockPark> mockList = [
    MockPark("mock 1",32.11795, 34.81906, 32.11614, 34.8212, 0.3333333333333333*60),
    MockPark("mock 2",32.11795, 34.69, 32.11614, 34.81906, 0.3333333333333333*60),
    MockPark("mock 3",32.11795, 34.81474, 32.11614, 34.8169, 0.3333333333333333*60),
  ];
}


class MockPark{
  final String name;
  final double top;
  final double left;
  final double bottom;
  final double right;
  final avg;

  MockPark(this.name,this.top, this.left, this.bottom, this.right, this.avg);

  double get centerY => (top+bottom)/2;
  double get centerX => (left+right)/2;
  LatLng get center =>LatLng(centerY, centerX);
}