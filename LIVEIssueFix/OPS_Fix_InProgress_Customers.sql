USE Tescosubscription
GO

/*
Author:   Robin
Purpose:  To update the payment process status from 5 to 6 for the customers in OPS
*/
-- Update the NextPaymentDate and NextRenewalDate for  Customers

UPDATE Tescosubscription.CustomerSubscription SET PaymentProcessStatus = 6,NextPaymentDate ='2014-01-11',UTCUpdatedDateTime = GETUTCDATE(),
NextRenewalDate = '2014-01-11'
WHERE CustomerSubscriptionID IN(33104,33157)


GO
-- Update only the NextPaymentDate customers

UPDATE Tescosubscription.CustomerSubscription SET PaymentProcessStatus = 6,NextPaymentDate ='2014-01-11',UTCUpdatedDateTime = GETUTCDATE()
WHERE CustomerSubscriptionID IN (33054,33102,32737,32756,33091,33055,33009,32830,32681,32682)
