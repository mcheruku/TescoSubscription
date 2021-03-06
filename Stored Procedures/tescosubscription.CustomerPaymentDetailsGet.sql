IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[CustomerPaymentDetailsGet] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentDetailsGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentDetailsGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentDetailsGet] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerPaymentDetailsGet]
(
	@CustomerSubsID BIGINT
)
AS

/*

	Author:			Apoorva Shivakumar
	Date created:	05/08/2011
	Purpose:		Returns Customer Payment Details
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>
	--exec [tescosubscription].[CustomerPaymentDetailsGet] 26,''
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	09 Aug 2011      Apoorva						Added 	remarks column 
	27 Dec 2011		Ramesh CH						Joined with newly created table CustomerPaymentHistoryResponse for remarks and paymentstatus

*/

	BEGIN
	
	  SET NOCOUNT ON		
	
		SELECT 
			ph.CustomerPaymentID,
			ph.PaymentAmount,
			--ph.PaymentStatusID,
			ph.PaymentDate, 
			cp.IsActive,
			CPHR.Remarks,
			cp.PaymentToken,
			SM.StatusName
		from  tescosubscription.CustomerPaymentHistory ph (NOLOCK)
		INNER JOIN tescosubscription.CustomerPaymentHistoryResponse CPHR ON CPHR.CustomerPaymentHistoryID=ph.CustomerPaymentHistoryID
			AND ph.CustomerSubscriptionID=@CustomerSubsID
		INNER JOIN tescosubscription.CustomerPayment cp (NOLOCK) ON cp.CustomerPaymentID=ph.CustomerPaymentID
		INNER JOIN tescosubscription.StatusMaster  SM (NOLOCK) ON CPHR.PaymentStatusID=SM.StatusId
		ORDER BY  ph.UTCUpdatedDateTime desc
	END
	



	

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentDetailsGet]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentDetailsGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentDetailsGet] not created.',16,1)
		
	END
GO