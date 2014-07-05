#!/bin/sh

nsql -U infinite -P bg3ntl <<- EOF

insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Anthony', 'So', NULL, 'Graphics Artist', '632', '842-7770 to 72', '18', NULL, NULL, '4', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Allan', 'Locke', 'alocke@infiniteinfo.com', 'CEO', '415', '777-1636', '206', '(415) 884-0602, (415) 8849575', '(415) 246-9575', '50', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Astrid', 'Crabbe', NULL, 'Asst. to the President', '415', '777-1636', '207', NULL, NULL, '51', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('David', 'Meistrell', NULL, 'Business Devt. Manager', '415', '777-1636', '210', NULL, NULL, '53', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Ben', 'Schwartz', NULL, 'Business Devt. Manager', '310', '664-8900', '204', NULL, NULL, '52', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Divya', 'Patel', 'divya@infiniteinfo.com', 'Solutions Manager', '415', '777-1636', '203', '(510) 471-2446', NULL, '54', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Doug', 'Thompson', NULL, 'Director - Pacific Northwest', '503', '299-6585', NULL, NULL, NULL, '55', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Hadi', 'Kusumo', NULL, 'Business Devt. Manager', '832', '467-1592', NULL, NULL, NULL, '56', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Ike', 'de Leon', 'ike@infiniteinfo.com', 'Solutions Manager', '415', '777-1636', '212', '(415) 337-7190', NULL, '57', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Jamie', 'Austin Sikora', NULL, 'Business Devt. Manager', '310', '664-8900', '205', NULL, NULL, '58', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Joe', 'Cooper', NULL, 'Business Devt. Manager', '310', '664-8900', '201', NULL, '(805) 630-2331', '59', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Juan', 'Ongpin', NULL, 'Business Devt. Manager', '415', '777-1636', '211', NULL, NULL, '60', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Noah', 'Richardson', 'noah@infiniteinfo.com', 'Solutions Manager', '415', '777-1636', '205', NULL, '(415) 505-0205', '62', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Paul', 'Cicerone', 'paulc@infiniteinfo.com', 'CMO', '415', '777-1636', '202', '(415) 893-1122', '(415) 602-6361', '63', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Shyuemin', 'Pang', 'spang@infiniteinfo.com', 'Director - Houston', '832', '467-1592', NULL, '(281) 920-3938', NULL, '64', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Yvonne', 'Locke', 'ylocke@infiniteinfo.com', 'President', '415', '777-1636', '201', '(415) 884-0602, (415) 8849575', '(415) 246-9575', '65', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Anna Liza', 'Inumerable', 'ayee@infiniteinfo.com', 'Project Manager', '632', '842-7770 to 72', '19', NULL, NULL, '2', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Carlo', 'Marcelino', 'carlo@infiniteinfo.com', 'Graphics Artist', '632', '842-7770 to 72', '18', NULL, NULL, '7', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Carmelo', 'Capinpin', 'mello@infiniteinfo.com', 'Interactive Programmer', '632', '842-7770 to 72', '17', NULL, NULL, '8', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Ava', 'Aldovino', 'aaldovino@infiniteinfo.com', 'QA Specialist', '632', '842-7770 to 72', '20', NULL, NULL, '5', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Cecille', 'Padilla', 'cecille@infiniteinfo.com', 'Project Manager', '632', '842-7770 to 72', '19', NULL, NULL, '10', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Connie', 'Dimayuga', 'cdimayuga@infiniteinfo.com', 'Project Manager', '632', '842-7770 to 72', '19', NULL, NULL, '11', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Dennis', 'Brucal', 'brucz@infiniteinfo.com', 'Interactive Programmer', '632', '842-7770 to 72', '17', NULL, NULL, '12', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Dennis', 'Castillo', 'deds@infiniteinfo.com', 'Software Engineer', '632', '842-7770 to 72', '17', NULL, '0918-8093833', '13', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Emerson', 'Esparrago', NULL, 'Graphics Artist', '632', '842-7770 to 72', '18', NULL, NULL, '14', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Emil', 'de Jesus', 'emil@infiniteinfo.com', 'Interactive Programmer', '632', '842-7770 to 72', '17', NULL, NULL, '15', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Emrich', 'Calabia', 'emrich@infiniteinfo.com', 'Interactive Programmer', '632', '842-7770 to 72', '17', NULL, NULL, '16', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Freeze', 'Logarta', 'alogarta@infiniteinfo.com', 'Software Engineer', '632', '842-7770 to 72', '17', NULL, NULL, '18', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Carolyn', 'dela Cruz', 'carol@infiniteinfo.com', 'HR Manager', '632', '842-7770 to 72', '16', NULL, '0919-3422545', '19', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Grace', 'Becongco', 'grace@infiniteinfo.com', 'Database Administrator', '632', '842-7770 to 72', '17', NULL, NULL, '20', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Allan Roy', 'Crisostomo', 'allanroy@infiniteinfo.com', 'HR Assistant', '632', '842-7770 to 72', '16', NULL, NULL, '1', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Hamilton', 'Chua', 'hchua@infiniteinfo.com', 'Software Engineer', '632', '842-7770 to 72', '17', NULL, NULL, '21', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Jan Michael', 'Aldeguer', 'mikko@infiniteinfo.com', 'Graphics Artist', '632', '842-7770 to 72', '18', NULL, NULL, '22', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Janni', 'Maravilla', 'janni@infiniteinfo.com', 'QA Specialist', '632', '842-7770 to 72', '20', NULL, NULL, '23', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Jennifer', 'Osias-de Jesus', 'jenny@infiniteinfo.com', 'Project Manager', '632', '842-7770 to 72', '19', NULL, NULL, '24', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Jenny', 'Rempillo', 'jrempillo@infiniteinfo.com', 'Purchasing Officer', '632', '842-7770 to 72', '23', NULL, NULL, '25', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Joey', 'Palencia', 'joey@infiniteinfo.com', 'Computer Technician', '632', '842-7770 to 72', '24', NULL, NULL, '26', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Jong', 'Reyes', 'jong@infiniteinfo.com', 'Graphics Artist', '632', '842-7770 to 72', '18', NULL, NULL, '27', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Kristine', 'del Villar', 'kdelvillar@infiniteinfo.com', 'Project Manager', '632', '842-7770 to 72', '19', NULL, NULL, '28', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Liberato', 'Yamog', 'lyamog@infiniteinfo.com', 'Software Engineer', '632', '842-7770 to 72', '17', NULL, '0917-9261006', '29', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Lyshiel', 'Valencia', 'lyshiel@infiniteinfo.com', 'Senior Project Manager', '632', '842-7770 to 72', '19', NULL, '0917-8380712', '30', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Marlon', 'Malabanan', 'marlon@infiniteinfo.com', 'Software Engineer', '632', '842-7770 to 72', '17', NULL, NULL, '31', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Marvic', 'Gonzales', 'mgonzales@infiniteinfo.com', 'Utility Man', '632', '842-7770 to 72', '24', NULL, NULL, '32', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Mary Jane', 'Cruz', NULL, 'Accounting Clerk', '632', '842-7770 to 72', '21', NULL, NULL, '33', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Michael', 'Basi', 'mbasi@infiniteinfo.com', 'Interactive Programmer', '632', '842-7770 to 72', '17', NULL, NULL, '34', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Michael Brian', 'Bonilla', 'brian@infiniteinfo.com', 'Accounting Manager', '632', '842-7770 to 72', '21', NULL, NULL, '35', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Arnel', 'Estanislao', 'arnel@infiniteinfo.com', 'Programming Director', '632', '842-7770 to 72', '14', NULL, '0917-9213026', '3', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Michael', 'Ramos', 'mike@infiniteinfo.com', 'VP Operations', '632', '842-7770 to 72', '13', NULL, '0917-8908309', '36', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Michelle', 'Alvarado', 'malvarado@infiniteinfo.com', 'QA Specialist', '632', '842-7770 to 72', '20', NULL, NULL, '37', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Nicolette', 'Salubayba', 'nikki@infiniteinfo.com', 'Receptionist', '632', '842-7770 to 72', '15', NULL, NULL, '38', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Quintin', 'Nobleza II', 'nonong@infiniteinfo.com', 'Finance Manager', '632', '842-7770 to 72', '21', NULL, '0917-8993751', '39', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Rene', 'Guillen', 'rene@infiniteinfo.com', 'Graphics Supervisor', '632', '842-7770 to 72', '18', NULL, '0197-9789229', '40', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Rey', 'Mangulantao', 'rey@infiniteinfo.com', 'Utility Man', '632', '842-7770 to 72', '24', NULL, NULL, '41', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Reynald', 'Atillo', 'reynald@infiniteinfo.com', 'Interactive Programmer', '632', '842-7770 to 72', '17', NULL, NULL, '42', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Robert', 'Locke', 'rlocke@infiniteinfo.com', 'CTO', '632', '842-7770 to 72', '11', NULL, '0917-4068212', '43', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Roel', 'Canicula', 'roel@infiniteinfo.com', 'Software Engineer', '632', '842-7770 to 72', '17', NULL, NULL, '44', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Roselle', 'Berin', 'roselle@infiniteinfo.com', 'QA Specialist', '632', '842-7770 to 72', '20', NULL, NULL, '45', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Sheila', 'Eugenio', 'sheila@infiniteinfo.com', 'Software Engineer', '632', '842-7770 to 72', '17', NULL, NULL, '46', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Sherwin', 'Chua', 'sherwin@infiniteinfo.com', 'Network Administrator', '632', '842-7770 to 72', '22', NULL, NULL, '47', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Sherwin', 'Togonon', 'stogonon@infiniteinfo.com', 'Graphics Artist', '632', '842-7770 to 72', '18', NULL, NULL, '48', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Tom', 'Favis', 'tom@infiniteinfo.com', 'Graphics Artist', '632', '842-7770 to 72', '18', NULL, NULL, '49', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Fred', 'Utanes', 'fred@infiniteinfo.com', 'General Manager', '632', '842-7770 to 72', '12', '(632) 642-9957', '0918-9126986', '17', 'IP');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Katrina', 'Craig', NULL, 'Director - London', NULL, '44 20 7838 2904', NULL, NULL, '44 77 8841 7056', '61', 'II');
insert into directory (first_name, last_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, id, location)
    values ('Buddy', 'Velayo', 'aavelayo@infiniteinfo.com', 'CFO', NULL, NULL, NULL, NULL, '0917-8313054', '9', 'IP');

EOF
