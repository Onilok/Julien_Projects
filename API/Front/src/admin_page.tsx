// import axios from "axios";
// import { useEffect, useState } from "react";
// import { jwtDecode } from "jwt-decode";
// import { useParams } from "react-router-dom";

// interface Product {
//   id: number;
//   bubble_tea: string;
//   user_id: number;
// }

// function admin() {
//   const params = useParams<{ tag: string }>();
//   const token = localStorage.getItem("token");
//   const decoded = jwtDecode(token!);
//   const id = decoded.sub;
//   const [product, setProduct] = useState<Product>({
//     id: 0,
//     bubble_tea: "",
//     user_id: 0,
//   });
//   function delete_all_product() {
//     useEffect(() => {
//       axios
//         .delete<Product>(`http://localhost:5000/delete_product_admin/${id}`)
//         .then((res) => setProduct(res.data))
//         .catch((err) => {
//           setError(err.message);
//         });
//     }, []);
//   }

//   function delete_one_product() {
//     useEffect(() => {
//       axios
//         .delete<Product>(
//           `http://localhost:5000/delete_product_admin/${id}/${params}`
//         )
//         .then((res) => setProduct(res.data))
//         .catch((err) => {
//           setError(err.message);
//         });
//     }, []);
//   }

//   function add_product() {
//     useEffect(() => {
//       axios
//         .post<Product>(`http://localhost:5000/add_product_admin/${id}`)
//         .then((res) => setProduct(res.data))
//         .catch((err) => {
//           setError(err.message);
//         });
//     }, []);
//   }

//   function update_product() {
//     useEffect(() => {
//       axios
//         .put<Product>(`http://localhost:5000/update_product_admin`)
//         .then((res) => setProduct(res.data))
//         .catch((err) => {
//           setError(err.message);
//         });
//     }, []);
//   }
//   const [error, setError] = useState("");

//   const handleChange = (event: any) => {
//     const name = event.target.name;
//     const value = event.target.value;
//     setProduct((values) => ({ ...values, [name]: value }));
//   };

//   const handleSubmit = (event: any) => {
//     event.preventDefault();
//     setProduct({
//       id: 0,
//       bubble_tea: "",
//       user_id: 0,
//     });
//   };
//   return (
//     <>
//       {error && <p className="text-danger">{error}</p>}
//       <div>
//         <form onSubmit={handleSubmit}>
//           <label> change your bubble tea name :</label>
//           <input
//             type="text"
//             id="bubble_tea"
//             name="bubble_tea"
//             value={product.bubble_tea}
//             onChange={handleChange}
//           ></input>
//           <p>click here to update your product</p>
//           <button
//             type="submit"
//             value="Envoyer"
//             // onClick={(e: any) => update_product()}
//           ></button>

//           <label> add your product</label>
//           <input
//             type="text"
//             id="bubble_tea"
//             name="bubble_tea"
//             value={product.bubble_tea}
//             onChange={handleChange}
//           ></input>

//           <p>click here to add product</p>
//           <button
//             type="submit"
//             value="Envoyer"
//             // onClick={(e: any) => add_product()}
//           ></button>

//           <p>click here to delete all product</p>
//           <button
//             type="submit"
//             value="Envoyer"
//             // onClick={(e: any) => delete_all_product()}
//           ></button>
//         </form>
//       </div>
//     </>
//   );
// }

// export default admin;
