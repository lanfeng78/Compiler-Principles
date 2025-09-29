(* 
 * queue.cl
 *
 * 一个用COOL语言实现的通用队列的数据结构
 *)

(*
 * QueueNode 类
 * 代表队列中的一个节点。它包含一个数据项(item)和指向下一个节点的指针(next)。
 * 这是一个典型的链表节点实现。
 *)


class QueueNode inherits Object {
	item : Object;
	next : QueueNode;
	
	-- 初始化节点
	init(i :  Object, n : QueueNode) : QueueNode {
		{
			item <- i;
			next <- n;
			self;
		}
	};

	-- 返回节点的数据
	getItem() : Object {
		item
	};

	-- 返回下一个节点
	getNext() : QueueNode {
		next
	};

};


(*
 * Queue 类
 * 实现了队列的核心功能。内部使用QueueNode构成的链表来存储数据。
 *)

class Queue inherits IO {
	front : QueueNode;
	rear : QueueNode;

	-- isEmpty(): 检查队列是否为空
	isEmpty() : Bool {
		isvoid front
	};

	-- enqueue(item): 将元素加入队尾
	enqueue(item : Object) : SELF_TYPE {
		{
			let new_node : QueueNode <- (new QueueNode).init(item, void) in
				if isEmpty() then 
					{
						front <- new_node;
						rear <- new_node;
					}
				else 
					{
						rear.next <- new_node;
						rear <- rear.next;
					}
				fi;
			self;
		}	
	};
	
	-- dequeue(): 移除并返回队首元素
	dequeue() : Object {
		if isEmpty() then 
			{
				out_string("Error: dequeue from an empty queue.\n");
				abort();
				new Object;
			}
		else 
			let item_to_return : Object <- front.getItem() in
				{
					front <- front.next;
					
					if isvoid front then
						rear <- void;
					fi;
					
					item_to_return
				}
		fi;
	};

	-- front(): 返回队首元素，但不移除它
	front() : Object {
		if isEmpty() then
                        { 
				out_string("Error: dequeue from an empty queue.\n");  
                                abort();
                                new Object;
                        }
                else
                        front.getItem();
                fi;	
	};

	-- print(): 打印队列内所有元素
	print() : SELF_TYPE {
		{
			if isEmpty() then
				out_string("Queue is empth.\n");
			else
				{
					out_stirng("----- Front of Queue -----\n");
					let current : QueueNode <- front in
						while not (isvoid current) loop {
							case current.getItem() of
								s : String => { out_string(s); out_string("\n") };
								i : Int => { out_int(i); out_string("\n") };
								o : Object => out_string("Unprintable Object\n");
							esac;
							current <- current.getNext();
						} pool;
						out_string("----- Bottom of Queue -----\n");
				}
			fi;
			self;
		}
	};
};  



class Main inherits IO {
	main() : Object {
		let my_queue : Queue <- new Queue in
		{
			out_string("--- Queue Demo ---\n\n");
			
			-- 1. 测试初始状态
			out_string("Is queue empty?\n");
			if my_queue.isEmpty() then out_string("Yes\n") else out_string("No\n") fi;
			my_queue.print();
			out_string("\n");
		
			-- 2. 推入一些元素 (字符串和整数)
			out_string("Pushing 'Alice', 100, 'Bob'...\n");
			my_queue.enqueue("Alice");
			my_queue.enqueue(100);
			my_queue.enqueue("Bob");
			my_queue.print();
			out_string("\n");

			-- 3. 测试 front
			out_string("Getting top element: ");
			case my_queue.front() of
				s : String => out_string(s);
				i : Int => out_int(i);
				o : Object => out_string("Object");
			esac;
			out_string("\n\n");
			
			-- 4. 测试 dequeue
			out_string("Dequeuing front element: ");
			case my_queue.dequeue() of
				s : String =>  out_string(s);
				i : Int => out_int(i);
				o : Object => out_string("Object");
			esac;
			out_string("\n");
			my_queue.print();
		}
	}
	
};

































