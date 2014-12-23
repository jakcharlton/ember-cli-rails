export default function(){
  this.transition(
    // this.fromRoute('contacts.index'),
    this.toRoute('contact'),
    this.use('toLeft'),
    this.reverse('toRight')
  );
}