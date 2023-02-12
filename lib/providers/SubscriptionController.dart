import 'package:get/get.dart';

class SubscriptionController extends GetxController 
  {
    var isSelected=[].obs;

    var unsubscribe=[].obs;
    void changeSelection(int index)
    {
      if(isSelected.contains(index))
      {
        isSelected.remove(index);
      }
      else
       isSelected.add(index);
    }

    void removeSubscription(int index)
    {
      if(unsubscribe.contains(index))
      {
        unsubscribe.remove(index);
      }
      else
       unsubscribe.add(index);
    }
  }