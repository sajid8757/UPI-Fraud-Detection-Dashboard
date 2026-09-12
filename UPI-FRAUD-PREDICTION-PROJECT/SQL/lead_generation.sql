SELECT current_user;
select * from business_leads;

INSERT INTO business_leads (business_name, website, email, domain, is_mx_valid, status)
VALUES ('Test Business', 'https://test.com', 'YOUR_PERSONAL_EMAIL@gmail.com', 'gmail.com', TRUE, 'Unsent')
ON CONFLICT (email) DO UPDATE SET status = 'Unsent';



UPDATE  business_leads
SET email = 'golurajahdn2003@gmail.com'
WHERE business_name = 'Test Business';