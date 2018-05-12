IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentSave]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentSave] not dropped.',16,1)
			END
	END
GO






CREATE PROCEDURE [tescosubscription].[CustomerPaymentSave] 
(
	@CustomerID					BIGINT
	,@PaymentModeID				TINYINT
	,@PaymentToken				NVARCHAR(44)
)
AS
/*  Author:			Rajendra Singh
	Date created:	22 July 2011
	Purpose:		Create a Customer Payment
	Behaviour:		Inserts a CustomerPayment Detail if it does not exist already and makes other Payment Detail specific to the Customer as Inactive
	Usage:			Whenever a customer Places a new Payment Detail
	Called by:		Appstore method CreateCustomerPayment
	WarmUP Script:	Execute [tescosubscription].[CustomerPaymentSave] 121334, 1, 'asdfaf'
--Modifications History--
	Changed On		Changed By			Defect Ref		Change Description
	25-Aug-2011		Manjunathan Raman					Insert as Inactive
	05-Nov-2013     Robin                               Added CAST for Payment Token
*/


BEGIN

	DECLARE		 @CustomerPaymentID	BIGINT

	SET NOCOUNT ON;	
		
		SELECT @CustomerPaymentID=CustomerPaymentID FROM [tescosubscription].[CustomerPayment]
		                WHERE CustomerID		=	@CustomerID
						AND		CAST(PaymentToken AS VARBINARY(90))	=	CAST(@PaymentToken AS VARBINARY(90))
						AND		PaymentModeID	=	@PaymentModeID
				
		IF  @@rowcount =0
		BEGIN	--##
--	Create record for customer payment and make this InActive.
		
				INSERT INTO [tescosubscription].[CustomerPayment]
				   (
						[CustomerID]
					   ,[PaymentModeID]
					   ,[PaymentToken]
				   )
				 OUTPUT inserted.CustomerPaymentID
				VALUES
				   (
						@CustomerID	
						,@PaymentModeID			
						,@PaymentToken
					)
			
	
		END		--##
		
	select @CustomerPaymentID CustomerPaymentID		
				
END
GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerPaymentSave] TO [SubsUser]

GO


IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentSave] not created.',16,1)
	END
GO
