// Code generated by Stan version 2.18.1

#include <stan/model/model_header.hpp>

namespace m13_2_model_model_namespace {

using std::istream;
using std::string;
using std::stringstream;
using std::vector;
using stan::io::dump;
using stan::math::lgamma;
using stan::model::prob_grad;
using namespace stan::math;

static int current_statement_begin__;

stan::io::program_reader prog_reader__() {
    stan::io::program_reader reader;
    reader.add_event(0, 0, "start", "/home/travis/build/StanJulia/StatisticalRethinking.jl/docs/build/13/tmp/m13_2_model.stan");
    reader.add_event(28, 26, "end", "/home/travis/build/StanJulia/StatisticalRethinking.jl/docs/build/13/tmp/m13_2_model.stan");
    return reader;
}

class m13_2_model_model : public prob_grad {
private:
    int N;
    int N_depts;
    vector<int> applications;
    vector<int> admit;
    vector<double> male;
    vector<int> dept_id;
public:
    m13_2_model_model(stan::io::var_context& context__,
        std::ostream* pstream__ = 0)
        : prob_grad(0) {
        ctor_body(context__, 0, pstream__);
    }

    m13_2_model_model(stan::io::var_context& context__,
        unsigned int random_seed__,
        std::ostream* pstream__ = 0)
        : prob_grad(0) {
        ctor_body(context__, random_seed__, pstream__);
    }

    void ctor_body(stan::io::var_context& context__,
                   unsigned int random_seed__,
                   std::ostream* pstream__) {
        typedef double local_scalar_t__;

        boost::ecuyer1988 base_rng__ =
          stan::services::util::create_rng(random_seed__, 0);
        (void) base_rng__;  // suppress unused var warning

        current_statement_begin__ = -1;

        static const char* function__ = "m13_2_model_model_namespace::m13_2_model_model";
        (void) function__;  // dummy to suppress unused var warning
        size_t pos__;
        (void) pos__;  // dummy to suppress unused var warning
        std::vector<int> vals_i__;
        std::vector<double> vals_r__;
        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // suppress unused var warning

        // initialize member variables
        try {
            current_statement_begin__ = 2;
            context__.validate_dims("data initialization", "N", "int", context__.to_vec());
            N = int(0);
            vals_i__ = context__.vals_i("N");
            pos__ = 0;
            N = vals_i__[pos__++];
            current_statement_begin__ = 3;
            context__.validate_dims("data initialization", "N_depts", "int", context__.to_vec());
            N_depts = int(0);
            vals_i__ = context__.vals_i("N_depts");
            pos__ = 0;
            N_depts = vals_i__[pos__++];
            current_statement_begin__ = 4;
            validate_non_negative_index("applications", "N", N);
            context__.validate_dims("data initialization", "applications", "int", context__.to_vec(N));
            validate_non_negative_index("applications", "N", N);
            applications = std::vector<int>(N,int(0));
            vals_i__ = context__.vals_i("applications");
            pos__ = 0;
            size_t applications_limit_0__ = N;
            for (size_t i_0__ = 0; i_0__ < applications_limit_0__; ++i_0__) {
                applications[i_0__] = vals_i__[pos__++];
            }
            current_statement_begin__ = 5;
            validate_non_negative_index("admit", "N", N);
            context__.validate_dims("data initialization", "admit", "int", context__.to_vec(N));
            validate_non_negative_index("admit", "N", N);
            admit = std::vector<int>(N,int(0));
            vals_i__ = context__.vals_i("admit");
            pos__ = 0;
            size_t admit_limit_0__ = N;
            for (size_t i_0__ = 0; i_0__ < admit_limit_0__; ++i_0__) {
                admit[i_0__] = vals_i__[pos__++];
            }
            current_statement_begin__ = 6;
            validate_non_negative_index("male", "N", N);
            context__.validate_dims("data initialization", "male", "double", context__.to_vec(N));
            validate_non_negative_index("male", "N", N);
            male = std::vector<double>(N,double(0));
            vals_r__ = context__.vals_r("male");
            pos__ = 0;
            size_t male_limit_0__ = N;
            for (size_t i_0__ = 0; i_0__ < male_limit_0__; ++i_0__) {
                male[i_0__] = vals_r__[pos__++];
            }
            current_statement_begin__ = 7;
            validate_non_negative_index("dept_id", "N", N);
            context__.validate_dims("data initialization", "dept_id", "int", context__.to_vec(N));
            validate_non_negative_index("dept_id", "N", N);
            dept_id = std::vector<int>(N,int(0));
            vals_i__ = context__.vals_i("dept_id");
            pos__ = 0;
            size_t dept_id_limit_0__ = N;
            for (size_t i_0__ = 0; i_0__ < dept_id_limit_0__; ++i_0__) {
                dept_id[i_0__] = vals_i__[pos__++];
            }

            // validate, data variables
            current_statement_begin__ = 2;
            current_statement_begin__ = 3;
            current_statement_begin__ = 4;
            current_statement_begin__ = 5;
            current_statement_begin__ = 6;
            current_statement_begin__ = 7;
            // initialize data variables


            // validate transformed data

            // validate, set parameter ranges
            num_params_r__ = 0U;
            param_ranges_i__.clear();
            current_statement_begin__ = 10;
            validate_non_negative_index("a_dept", "N_depts", N_depts);
            num_params_r__ += N_depts;
            current_statement_begin__ = 11;
            ++num_params_r__;
            current_statement_begin__ = 12;
            ++num_params_r__;
            current_statement_begin__ = 13;
            ++num_params_r__;
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }
    }

    ~m13_2_model_model() { }


    void transform_inits(const stan::io::var_context& context__,
                         std::vector<int>& params_i__,
                         std::vector<double>& params_r__,
                         std::ostream* pstream__) const {
        stan::io::writer<double> writer__(params_r__,params_i__);
        size_t pos__;
        (void) pos__; // dummy call to supress warning
        std::vector<double> vals_r__;
        std::vector<int> vals_i__;

        if (!(context__.contains_r("a_dept")))
            throw std::runtime_error("variable a_dept missing");
        vals_r__ = context__.vals_r("a_dept");
        pos__ = 0U;
        validate_non_negative_index("a_dept", "N_depts", N_depts);
        context__.validate_dims("initialization", "a_dept", "vector_d", context__.to_vec(N_depts));
        vector_d a_dept(static_cast<Eigen::VectorXd::Index>(N_depts));
        for (int j1__ = 0U; j1__ < N_depts; ++j1__)
            a_dept(j1__) = vals_r__[pos__++];
        try {
            writer__.vector_unconstrain(a_dept);
        } catch (const std::exception& e) { 
            throw std::runtime_error(std::string("Error transforming variable a_dept: ") + e.what());
        }

        if (!(context__.contains_r("a")))
            throw std::runtime_error("variable a missing");
        vals_r__ = context__.vals_r("a");
        pos__ = 0U;
        context__.validate_dims("initialization", "a", "double", context__.to_vec());
        double a(0);
        a = vals_r__[pos__++];
        try {
            writer__.scalar_unconstrain(a);
        } catch (const std::exception& e) { 
            throw std::runtime_error(std::string("Error transforming variable a: ") + e.what());
        }

        if (!(context__.contains_r("bm")))
            throw std::runtime_error("variable bm missing");
        vals_r__ = context__.vals_r("bm");
        pos__ = 0U;
        context__.validate_dims("initialization", "bm", "double", context__.to_vec());
        double bm(0);
        bm = vals_r__[pos__++];
        try {
            writer__.scalar_unconstrain(bm);
        } catch (const std::exception& e) { 
            throw std::runtime_error(std::string("Error transforming variable bm: ") + e.what());
        }

        if (!(context__.contains_r("sigma_dept")))
            throw std::runtime_error("variable sigma_dept missing");
        vals_r__ = context__.vals_r("sigma_dept");
        pos__ = 0U;
        context__.validate_dims("initialization", "sigma_dept", "double", context__.to_vec());
        double sigma_dept(0);
        sigma_dept = vals_r__[pos__++];
        try {
            writer__.scalar_lb_unconstrain(0,sigma_dept);
        } catch (const std::exception& e) { 
            throw std::runtime_error(std::string("Error transforming variable sigma_dept: ") + e.what());
        }

        params_r__ = writer__.data_r();
        params_i__ = writer__.data_i();
    }

    void transform_inits(const stan::io::var_context& context,
                         Eigen::Matrix<double,Eigen::Dynamic,1>& params_r,
                         std::ostream* pstream__) const {
      std::vector<double> params_r_vec;
      std::vector<int> params_i_vec;
      transform_inits(context, params_i_vec, params_r_vec, pstream__);
      params_r.resize(params_r_vec.size());
      for (int i = 0; i < params_r.size(); ++i)
        params_r(i) = params_r_vec[i];
    }


    template <bool propto__, bool jacobian__, typename T__>
    T__ log_prob(vector<T__>& params_r__,
                 vector<int>& params_i__,
                 std::ostream* pstream__ = 0) const {

        typedef T__ local_scalar_t__;

        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // suppress unused var warning

        T__ lp__(0.0);
        stan::math::accumulator<T__> lp_accum__;

        try {
            // model parameters
            stan::io::reader<local_scalar_t__> in__(params_r__,params_i__);

            Eigen::Matrix<local_scalar_t__,Eigen::Dynamic,1>  a_dept;
            (void) a_dept;  // dummy to suppress unused var warning
            if (jacobian__)
                a_dept = in__.vector_constrain(N_depts,lp__);
            else
                a_dept = in__.vector_constrain(N_depts);

            local_scalar_t__ a;
            (void) a;  // dummy to suppress unused var warning
            if (jacobian__)
                a = in__.scalar_constrain(lp__);
            else
                a = in__.scalar_constrain();

            local_scalar_t__ bm;
            (void) bm;  // dummy to suppress unused var warning
            if (jacobian__)
                bm = in__.scalar_constrain(lp__);
            else
                bm = in__.scalar_constrain();

            local_scalar_t__ sigma_dept;
            (void) sigma_dept;  // dummy to suppress unused var warning
            if (jacobian__)
                sigma_dept = in__.scalar_lb_constrain(0,lp__);
            else
                sigma_dept = in__.scalar_lb_constrain(0);


            // transformed parameters



            // validate transformed parameters

            const char* function__ = "validate transformed params";
            (void) function__;  // dummy to suppress unused var warning

            // model body
            {
            current_statement_begin__ = 16;
            validate_non_negative_index("p", "N", N);
            Eigen::Matrix<local_scalar_t__,Eigen::Dynamic,1>  p(static_cast<Eigen::VectorXd::Index>(N));
            (void) p;  // dummy to suppress unused var warning

            stan::math::initialize(p, DUMMY_VAR__);
            stan::math::fill(p,DUMMY_VAR__);


            current_statement_begin__ = 17;
            lp_accum__.add(cauchy_log<propto__>(sigma_dept, 0, 2));
            current_statement_begin__ = 18;
            lp_accum__.add(normal_log<propto__>(bm, 0, 1));
            current_statement_begin__ = 19;
            lp_accum__.add(normal_log<propto__>(a, 0, 10));
            current_statement_begin__ = 20;
            lp_accum__.add(normal_log<propto__>(a_dept, a, sigma_dept));
            current_statement_begin__ = 21;
            for (int i = 1; i <= N; ++i) {

                current_statement_begin__ = 22;
                stan::model::assign(p, 
                            stan::model::cons_list(stan::model::index_uni(i), stan::model::nil_index_list()), 
                            (get_base1(a_dept,get_base1(dept_id,i,"dept_id",1),"a_dept",1) + (bm * get_base1(male,i,"male",1))), 
                            "assigning variable p");
                current_statement_begin__ = 23;
                stan::model::assign(p, 
                            stan::model::cons_list(stan::model::index_uni(i), stan::model::nil_index_list()), 
                            stan::model::deep_copy(inv_logit(get_base1(p,i,"p",1))), 
                            "assigning variable p");
            }
            current_statement_begin__ = 25;
            lp_accum__.add(binomial_log<propto__>(admit, applications, p));
            }

        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }

        lp_accum__.add(lp__);
        return lp_accum__.sum();

    } // log_prob()

    template <bool propto, bool jacobian, typename T_>
    T_ log_prob(Eigen::Matrix<T_,Eigen::Dynamic,1>& params_r,
               std::ostream* pstream = 0) const {
      std::vector<T_> vec_params_r;
      vec_params_r.reserve(params_r.size());
      for (int i = 0; i < params_r.size(); ++i)
        vec_params_r.push_back(params_r(i));
      std::vector<int> vec_params_i;
      return log_prob<propto,jacobian,T_>(vec_params_r, vec_params_i, pstream);
    }


    void get_param_names(std::vector<std::string>& names__) const {
        names__.resize(0);
        names__.push_back("a_dept");
        names__.push_back("a");
        names__.push_back("bm");
        names__.push_back("sigma_dept");
    }


    void get_dims(std::vector<std::vector<size_t> >& dimss__) const {
        dimss__.resize(0);
        std::vector<size_t> dims__;
        dims__.resize(0);
        dims__.push_back(N_depts);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
        dims__.resize(0);
        dimss__.push_back(dims__);
    }

    template <typename RNG>
    void write_array(RNG& base_rng__,
                     std::vector<double>& params_r__,
                     std::vector<int>& params_i__,
                     std::vector<double>& vars__,
                     bool include_tparams__ = true,
                     bool include_gqs__ = true,
                     std::ostream* pstream__ = 0) const {
        typedef double local_scalar_t__;

        vars__.resize(0);
        stan::io::reader<local_scalar_t__> in__(params_r__,params_i__);
        static const char* function__ = "m13_2_model_model_namespace::write_array";
        (void) function__;  // dummy to suppress unused var warning
        // read-transform, write parameters
        vector_d a_dept = in__.vector_constrain(N_depts);
        double a = in__.scalar_constrain();
        double bm = in__.scalar_constrain();
        double sigma_dept = in__.scalar_lb_constrain(0);
            for (int k_0__ = 0; k_0__ < N_depts; ++k_0__) {
            vars__.push_back(a_dept[k_0__]);
            }
        vars__.push_back(a);
        vars__.push_back(bm);
        vars__.push_back(sigma_dept);

        // declare and define transformed parameters
        double lp__ = 0.0;
        (void) lp__;  // dummy to suppress unused var warning
        stan::math::accumulator<double> lp_accum__;

        local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
        (void) DUMMY_VAR__;  // suppress unused var warning

        try {



            // validate transformed parameters

            // write transformed parameters
            if (include_tparams__) {
            }
            if (!include_gqs__) return;
            // declare and define generated quantities



            // validate generated quantities

            // write generated quantities
        } catch (const std::exception& e) {
            stan::lang::rethrow_located(e, current_statement_begin__, prog_reader__());
            // Next line prevents compiler griping about no return
            throw std::runtime_error("*** IF YOU SEE THIS, PLEASE REPORT A BUG ***");
        }
    }

    template <typename RNG>
    void write_array(RNG& base_rng,
                     Eigen::Matrix<double,Eigen::Dynamic,1>& params_r,
                     Eigen::Matrix<double,Eigen::Dynamic,1>& vars,
                     bool include_tparams = true,
                     bool include_gqs = true,
                     std::ostream* pstream = 0) const {
      std::vector<double> params_r_vec(params_r.size());
      for (int i = 0; i < params_r.size(); ++i)
        params_r_vec[i] = params_r(i);
      std::vector<double> vars_vec;
      std::vector<int> params_i_vec;
      write_array(base_rng,params_r_vec,params_i_vec,vars_vec,include_tparams,include_gqs,pstream);
      vars.resize(vars_vec.size());
      for (int i = 0; i < vars.size(); ++i)
        vars(i) = vars_vec[i];
    }

    static std::string model_name() {
        return "m13_2_model_model";
    }


    void constrained_param_names(std::vector<std::string>& param_names__,
                                 bool include_tparams__ = true,
                                 bool include_gqs__ = true) const {
        std::stringstream param_name_stream__;
        for (int k_0__ = 1; k_0__ <= N_depts; ++k_0__) {
            param_name_stream__.str(std::string());
            param_name_stream__ << "a_dept" << '.' << k_0__;
            param_names__.push_back(param_name_stream__.str());
        }
        param_name_stream__.str(std::string());
        param_name_stream__ << "a";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "bm";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "sigma_dept";
        param_names__.push_back(param_name_stream__.str());

        if (!include_gqs__ && !include_tparams__) return;

        if (include_tparams__) {
        }


        if (!include_gqs__) return;
    }


    void unconstrained_param_names(std::vector<std::string>& param_names__,
                                   bool include_tparams__ = true,
                                   bool include_gqs__ = true) const {
        std::stringstream param_name_stream__;
        for (int k_0__ = 1; k_0__ <= N_depts; ++k_0__) {
            param_name_stream__.str(std::string());
            param_name_stream__ << "a_dept" << '.' << k_0__;
            param_names__.push_back(param_name_stream__.str());
        }
        param_name_stream__.str(std::string());
        param_name_stream__ << "a";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "bm";
        param_names__.push_back(param_name_stream__.str());
        param_name_stream__.str(std::string());
        param_name_stream__ << "sigma_dept";
        param_names__.push_back(param_name_stream__.str());

        if (!include_gqs__ && !include_tparams__) return;

        if (include_tparams__) {
        }


        if (!include_gqs__) return;
    }

}; // model

}

typedef m13_2_model_model_namespace::m13_2_model_model stan_model;

