import 'package:bayesiantech_assignment_part1/addcard/cardbloc.dart';
import 'package:bayesiantech_assignment_part1/classes/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Material(
                  color: Colors.grey[50],
                  elevation: 2,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30), 
                    bottomRight: Radius.circular(30)
                    ),
                  child: SizedBox(
                    height: 200,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          child: SizedBox(
                            height: 60,
                            width: size.width-10,
                            child: const Center(
                              child: Text(
                                'Add Comments',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                                )
                              ),
                          ),
                        ),
      
                        const Image(
                          height: 120,
                          image: AssetImage('assets/images/cardimage.png')
                          )
      
                      ],
                    ),              
                  ),
                ),
      
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                  child: Material(
                    elevation: 1,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: const Icon(Icons.search, color: Colors.black45,),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.transparent
                          )
                        ),
                        border: OutlineInputBorder(                          
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                    ),
                  ),
                ),
      
                SizedBox(
                  height: size.height*0.7,
                  child: BlocBuilder<CardBloc, List<MyComment>>(
                    builder: (context, state){
                      return ListView(
                        children: state.map((e) => Commentwidget(size: size, comment: e,)).toList(),
                      );
                    })
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Commentwidget extends StatelessWidget {
  const Commentwidget({super.key, required this.size, required this.comment});
  final Size size;
  final MyComment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey.shade400
          )
        ),
        color: Colors.grey.shade200,
        child: SizedBox(
          height: 50,
          width: size.width,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundColor: Colors.green.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: Center(
                            child: Text(
                              'IM',
                              style: TextStyle(
                                color: Colors.grey.shade700
                              ),
                              ),
                          ),
                        ),
                      )
                    ),
                  ))
                ),

              Expanded(
                flex: 5,
                child: Text(
                  comment.commentstring
                  )
                ),

              Expanded(
                flex: 1,
                child: comment.isposted? Icon(Icons.check, color: Colors.grey.shade600,) :
                IconButton(
                  onPressed: (){
                    showDialog(
                      context: context, 
                      builder: (context){
                        return MyDialogWidget(comment: comment,);
                        
                      }
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.grey.shade600,)))
            ],
          ),
        ),
      ),
    );
  }
}

class MyDialogWidget extends StatefulWidget {
  const MyDialogWidget({super.key, required this.comment});
  final MyComment comment;

  @override
  State<MyDialogWidget> createState() => _MyDialogWidgetState();
}

class _MyDialogWidgetState extends State<MyDialogWidget> {
  final TextEditingController _controller = TextEditingController();
  final dialogformkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Type below'),
      content: Form(
        key: dialogformkey,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10),
          child: TextFormField(
            validator: (value) {
              if (value == null) {
                return 'input text';
              } else {
                return null;
              }
            },
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Comment',
              filled: true,
              fillColor: Colors.grey.shade100,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent
                )
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                
                )
              )
            ),
          ),
        ),
      ),

      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            backgroundColor: Colors.deepPurple
          ),
          onPressed: (){
            if (dialogformkey.currentState!.validate()) {
              Navigator.pop(context);
              FocusManager.instance.primaryFocus?.unfocus();
              BlocProvider.of<CardBloc>(context).add(
                AddCardEvent(callingcomment: widget.comment, addedcomment: MyComment(_controller.text))
                );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  backgroundColor: Colors.grey.shade300,
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New comment was added', 
                          style: TextStyle(color: Colors.grey.shade800),),
                        Icon(Icons.check_circle_outline_outlined, color: Colors.grey.shade900,)
                      ],
                    ),
                  )
                  )
              );
            }
          }, 
          child: const Text('Add')
          ),
        
      ],
    );
  }
}