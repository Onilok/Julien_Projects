import { Route, Routes, BrowserRouter } from "react-router-dom";
import Register from "./register";
import Get_all_users from "./all_users";
import Login from "./login";
import Get_all_products from "./all_product";
import User_product from "./user_product";
import { Update_user } from "./update_user";
import { Product } from "./admin_test";
import Current_user from "./current_user";
// import admin from "./admin_page";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" />
        <Route path="/register" element={<Register />} />
        <Route path="/login" element={<Login />} />
        <Route path="/all_users" element={<Get_all_users />} />
        <Route path="/current_user" element={<Current_user />} />
        <Route path="/update_user" element={<Update_user />} />
        <Route path="/user_delete" />
        <Route path="/all_products" element={<Get_all_products />} />
        <Route path="/user_product" element={<User_product />} />
        {/* <Route path="/admin_page" element={admin()} />  */}
        <Route path="/product" element={<Product />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
