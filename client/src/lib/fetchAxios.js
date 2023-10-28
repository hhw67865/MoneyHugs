import axios from "axios";

const fetchAxios = async (obj, session) => {
  return axios({ ...obj, headers: { session_id: session.id } });
};

export default fetchAxios;