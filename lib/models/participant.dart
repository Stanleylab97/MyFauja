class Participant{
 late String? nom, prenom, barreau_annee, pays, email, contact, hotel, transport, dateArrive,dateDepart, personContact, numContact;
 late String? type;
 Participant({required this.nom,required this.prenom, this.barreau_annee,required this.type,required this.pays, required this.email, required this.contact, this.hotel, this.transport,required this.dateArrive,required this.dateDepart, this.personContact,this.numContact});

}