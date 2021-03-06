IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponseCreate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentHistoryResponseCreate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponseCreate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] not dropped.',16,1)
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[CustomerPaymentHistoryResponseCreate]
(
		--INPUT PARAMETERS HERE--
	 @CustomerPaymentHistoryID				BIGINT
	,@StatusID						TINYINT
	,@Remarks						VARCHAR(100) 
    
)
AS

/*

	Author:			Joji Isac
	Date created:	26 dec 2011
	Purpose:		To insert the payment attempt result in table CustomerPaymentHistoryResponse
	Behaviour:		This procedure is called from Appstore on receiving response from CPS
	Usage:			Often in batch
	Called by:		AppStore
	WarmUP Script:	Execute [tescosubscription].[CustomerPaymentHistoryResponseCreate] 11,0,'Subscriptions'
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	*/

BEGIN
				
	SET NOCOUNT ON

	INSERT INTO [tescosubscription].[CustomerPaymentHistoryResponse]
			   ([CustomerPaymentHistoryID]
			   ,[PaymentStatusID]
			   ,[Remarks])
		 VALUES
			   (
				@CustomerPaymentHistoryID
			   ,@StatusID
			   ,@Remarks  )

	
END


GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentHistoryResponseCreate] TO [SubsUser]
GO



IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponseCreate]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] not created.',16,1)
	END
GO


