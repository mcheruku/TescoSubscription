USE Tescosubscription
GO

/*
Author:   Robin
Purpose:  To update the payment process status from 6 to 5 for the customers in OPS
*/
-- Update the NextPaymentDate and NextRenewalDate for Customers

UPDATE Tescosubscription.CustomerSubscription SET PaymentProcessStatus = 5,NextPaymentDate ='2013-12-11',UTCUpdatedDateTime = GETUTCDATE(),
NextRenewalDate = '2013-12-11'
WHERE CustomerSubscriptionID IN (33104,33157)


GO
-- Update only the NextPaymentDate customers

UPDATE Tescosubscription.CustomerSubscription SET PaymentProcessStatus = 5,NextPaymentDate ='2013-12-11',UTCUpdatedDateTime = GETUTCDATE()
WHERE CustomerSubscriptionID IN (33054,33102,32737,32756,33091,33055,33009,32830,32681,32682)
