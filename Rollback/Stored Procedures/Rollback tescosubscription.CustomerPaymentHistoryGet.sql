IF OBJECT_ID('[tescosubscription].[CustomerPaymentHistoryGet]', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE [tescosubscription].[CustomerPaymentHistoryGet]

	IF OBJECT_ID('[tescosubscription].[CustomerPaymentHistoryGet]', 'P') IS NOT NULL
		RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerPaymentHistoryGet] - NOT DROPPED',16,1)
	ELSE
		PRINT 'SUCCESS: Stored Procedure:[tescosubscription].[CustomerPaymentHistoryGet] - DROPPED'
END
GO

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON
go


CREATE PROCEDURE [tescosubscription].[CustomerPaymentHistoryGet]
(
	@CustomerSubscriptionID	BIGINT
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get Customer Payment Details Based on CustomerSubscriptionID
    Behaviour:  How does this procedure actually work
    Usage:      Called By Juvo     

	--Modifications History--
 	Changed On        Changed By  Defect  Changes  Change Description 
	14th July 2014    Robin                        Added condition not to fetch PreAuth Records as per new requirement.		
*/
BEGIN

	
		 SELECT  
           CP.[CustomerID]
		  ,CP.[PaymentModeID]
		  ,CP.[PaymentToken]
		  ,PH.[PaymentDate]
		  ,PH.[PaymentAmount]
		  ,HR.[PaymentStatusID]
		  ,HR.[Remarks]      
		 FROM [TescoSubscription].[CustomerPayment] CP WITH (NOLOCK)
		 LEFT JOIN [TescoSubscription].[CustomerPaymentHistory] PH WITH (NOLOCK)
		 ON CP.CustomerPaymentID = PH.CustomerPaymentID
		 LEFT JOIN [TescoSubscription].[CustomerPaymentHistoryResponse] HR WITH (NOLOCK)
		 ON HR.CustomerPaymentHistoryID = PH.CustomerPaymentHistoryID
		 WHERE CustomerSubscriptionID = @CustomerSubscriptionID AND IsPreAuth=0
		 ORDER BY PH.[PaymentDate]

      
END
GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentHistoryGet] TO [SubsUser]
GO

-- Check Exists
IF OBJECT_ID('[tescosubscription].[CustomerPaymentHistoryGet]', 'P') IS NOT NULL
	PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerPaymentHistoryGet] - CREATED'
ELSE
	RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerPaymentHistoryGet] - NOT CREATED',16,1)
GO	




