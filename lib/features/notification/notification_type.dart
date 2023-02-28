class NotificationType {
  static const newRequest = 'New Request';
  static const requestAccepted = 'Request Accepted';
  static const requestRejected = 'Request Rejected';
  static const requestBidding = 'Request Bidding';
  static const requestCompleted = 'Request Completed';
  static const requestOngoing = 'Request Ongoing';

  static const newContract = 'New Contract';
  static const contractAccepted = 'Contract Accepted';
  static const contractRejected = 'Contract Rejected';
  static const contractOngoing = 'Contract Ongoing';
  static const contractCompleted = 'Contract Completed';
  static const contractAbandoned = 'contract Abandoned';

  static const newOrder = 'New Order'; //sent to Admin
  static const orderConfirmed = 'Order Confirmed'; //send to customer from admin
  static const orderProcessing =
      'Processing Order'; //sent to customer from admin
  static const orderDriverAssigned =
      'Driver Assigned'; //sent to customer and driver
  static const orderDeliveryStarted =
      'Order Delivery Started'; //sent to customer and admin
  static const orderDriverArrived =
      'Order Driver Arrived'; //send to customer and admin
  static const orderDriverDelivered =
      'Order Delivered'; //sent to admin and customer
  static const orderReceived = 'Order Received'; //sent to driver and customer

  static const driverInvitation =
      'Verification Invitation'; //sent to driver and customer
  static const driverVerification = 'Driver Verification';
  static const walletUp = 'Wallet Update';
}
